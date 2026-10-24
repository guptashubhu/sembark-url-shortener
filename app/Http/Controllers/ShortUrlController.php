<?php

namespace App\Http\Controllers;

use App\Models\ShortUrl;
use Illuminate\Http\Request;
use Illuminate\Support\Str;

class ShortUrlController extends Controller
{
    
    public function index(Request $request)
    {
        $user = $request->user();

        if ($user->role === 'superadmin') {
            // SuperAdmin can see URLs from every company.
            $shortUrls = ShortUrl::with(['user', 'company'])
                ->latest()
                ->get();
        } elseif ($user->role === 'admin') {
            // Admin can see URLs from their own company.
            $shortUrls = ShortUrl::with(['user', 'company'])
                ->where('company_id', $user->company_id)
                ->latest()
                ->get();
        } elseif ($user->role === 'member') {
            // Member can see only URLs created by them.
            $shortUrls = ShortUrl::with(['user', 'company'])
                ->where('user_id', $user->id)
                ->latest()
                ->get();
        } else {
            abort(403);
        }

        return view('dashboard', compact('shortUrls'));
    }

    public function store(Request $request)
    {
        $user = $request->user();

        // Only Admin and Member can create short URLs.
        if (!in_array($user->role, ['admin', 'member'])) {
            abort(403);
        }

        if (!$user->company_id) {
            abort(403, 'Your account is not assigned to a company.');
        }

        $data = $request->validate([
            'original_url' => ['required', 'url', 'max:2048'],
        ]);

        // Generate a unique short code.
        do {
            $code = Str::random(8);
        } while (ShortUrl::where('code', $code)->exists());

        ShortUrl::create([
            'company_id' => $user->company_id,
            'user_id' => $user->id,
            'original_url' => $data['original_url'],
            'code' => $code,
        ]);

        return redirect()->route('dashboard')
            ->with('success', 'Short URL created successfully!');
    }

    public function redirect(string $code)
    {
        $shortUrl = ShortUrl::where('code', $code)->firstOrFail();

        return redirect()->away($shortUrl->original_url);
    }
}
