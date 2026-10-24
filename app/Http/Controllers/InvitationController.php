<?php

namespace App\Http\Controllers;

use App\Models\Company;
use App\Models\Invitation;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;
use Illuminate\Validation\Rule;

class InvitationController extends Controller
{
    public function store(Request $request)
    {
        $user = $request->user();

        // SuperAdmin can invite only Admin.
        // Admin can invite Admin or Member.
        $allowedRoles = match ($user->role) {
            'superadmin' => ['admin'],
            'admin' => ['admin', 'member'],
            default => [],
        };

        abort_if(empty($allowedRoles), 403);

        $data = $request->validate([
            'email' => ['required', 'email', 'max:255'],
            'role' => ['required', Rule::in($allowedRoles)],
            'company_name' => [
                Rule::requiredIf($user->role === 'superadmin'),
                'nullable',
                'string',
                'max:255',
            ],
        ]);

        // Do not invite an existing user.
        if (DB::table('users')->where('email', $data['email'])->exists()) {
            return back()->withErrors([
                'email' => 'This email already has an account.',
            ]);
        }

        // Avoid duplicate pending invitations.
        $pendingExists = Invitation::where('email', $data['email'])->whereNull('accepted_at')->where('expires_at', '>', now())->exists();
        if ($pendingExists) {
            return back()->withErrors([
                'email' => 'An active invitation already exists.',
            ]);
        }

        $plainToken = Str::random(64);

        $invitation = DB::transaction(function () use ($user,$data,$plainToken) {
            if ($user->role === 'superadmin') {
                $company = Company::create([
                    'name' => $data['company_name'],
                ]);
            } else {
                abort_if(!$user->company_id, 403);

                $company = $user->company;
            }

            return Invitation::create([
                'company_id' => $company->id,
                'invited_by' => $user->id,
                'email' => $data['email'],
                'role' => $data['role'],
                'token_hash' => hash('sha256', $plainToken),
                'expires_at' => now()->addDays(2),
            ]);
        });

        // Temporary development flow:
        // show the invitation URL to the inviter.
        // In production, email this URL to the invitee.
        $inviteUrl = route('invitations.accept', [
            'token' => $plainToken,
        ]);

        return back()->with('invite_url',$inviteUrl);
    }

    public function showAcceptForm(string $token)
    {
        $invitation = Invitation::where('token_hash',hash('sha256', $token))->first();

        if (!$invitation || $invitation->accepted_at ||  $invitation->expires_at->isPast()) {
            abort(404, 'Invitation is invalid or expired.');
        }

        return view('invitations.accept', [
            'token' => $token,
            'invitation' => $invitation,
        ]);
    }

    public function accept(Request $request, string $token)
    {
        $invitation = Invitation::where('token_hash', hash('sha256', $token))->first();

        if (!$invitation || $invitation->accepted_at || $invitation->expires_at->isPast()) {
            abort(404, 'Invitation is invalid or expired.');
        }

        $data = $request->validate([
            'name' => ['required', 'string', 'max:255'],
            'password' => ['required', 'string', 'min:8', 'confirmed'],
        ]);

        DB::transaction(function () use ($invitation, $data) {
            $invitation = Invitation::whereKey(
                $invitation->id
            )->lockForUpdate()->firstOrFail();

            if (
                $invitation->accepted_at ||
                $invitation->expires_at->isPast()
            ) {
                abort(404, 'Invitation is invalid or expired.');
            }

            User::create([
                'name' => $data['name'],
                'email' => $invitation->email,
                'password' => Hash::make(
                    $data['password']
                ),
                'company_id' => $invitation->company_id,
                'role' => $invitation->role,
            ]);

            $invitation->update([
                'accepted_at' => now(),
            ]);
        });

        return redirect('/login')->with(
            'success',
            'Account created successfully. Please log in.'
        );
    }

}
