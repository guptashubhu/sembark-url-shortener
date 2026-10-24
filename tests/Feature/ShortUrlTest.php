<?php

namespace Tests\Feature;

use App\Models\Company;
use App\Models\ShortUrl;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Hash;
use Tests\TestCase;

class ShortUrlTest extends TestCase
{
    use RefreshDatabase;

    private function createCompany(string $name): Company
    {
        return Company::create([
            'name' => $name,
        ]);
    }

    private function createUser(
        string $role,
        ?int $companyId = null
    ): User {
        return User::create([
            'name' => ucfirst($role) . ' User',
            'email' => $role . uniqid() . '@example.com',
            'password' => Hash::make('password123'),
            'role' => $role,
            'company_id' => $companyId,
            'email_verified_at' => now(),
        ]);
    }

    private function createShortUrl(
        User $user,
        string $originalUrl,
        string $code
    ): ShortUrl {
        return ShortUrl::create([
            'company_id' => $user->company_id,
            'user_id' => $user->id,
            'original_url' => $originalUrl,
            'code' => $code,
        ]);
    }

    public function test_admin_can_create_short_url(): void
    {
        $company = $this->createCompany('Company A');
        $admin = $this->createUser('admin', $company->id);

        $response = $this->actingAs($admin)->post(
            route('shorturls.store'),
            ['original_url' => 'https://example.com']
        );

        $response->assertRedirect(route('dashboard'));

        $this->assertDatabaseHas('short_urls', [
            'company_id' => $company->id,
            'user_id' => $admin->id,
            'original_url' => 'https://example.com',
        ]);
    }

    public function test_member_can_create_short_url(): void
    {
        $company = $this->createCompany('Company A');
        $member = $this->createUser('member', $company->id);

        $this->actingAs($member)->post(
            route('shorturls.store'),
            ['original_url' => 'https://example.com/page']
        );

        $this->assertDatabaseHas('short_urls', [
            'user_id' => $member->id,
            'original_url' => 'https://example.com/page',
        ]);
    }

    public function test_superadmin_cannot_create_short_url(): void
    {
        $superAdmin = $this->createUser('superadmin');

        $response = $this->actingAs($superAdmin)->post(
            route('shorturls.store'),
            ['original_url' => 'https://example.com']
        );

        $response->assertForbidden();

        $this->assertDatabaseCount('short_urls', 0);
    }

    public function test_admin_sees_only_urls_from_own_company(): void
    {
        $companyA = $this->createCompany('Company A');
        $companyB = $this->createCompany('Company B');

        $admin = $this->createUser('admin', $companyA->id);
        $otherAdmin = $this->createUser('admin', $companyB->id);

        $this->createShortUrl(
            $admin,
            'https://company-a.example/page',
            'codeaaa1'
        );

        $this->createShortUrl(
            $otherAdmin,
            'https://company-b.example/page',
            'codebbb1'
        );

        $response = $this->actingAs($admin)->get(route('dashboard'));

        $response->assertOk();
        $response->assertSee('https://company-a.example/page');
        $response->assertDontSee('https://company-b.example/page');
    }

    public function test_member_sees_only_their_own_urls(): void
    {
        $company = $this->createCompany('Company A');

        $memberA = $this->createUser('member', $company->id);
        $memberB = $this->createUser('member', $company->id);

        $this->createShortUrl(
            $memberA,
            'https://member-a.example/page',
            'membera1'
        );

        $this->createShortUrl(
            $memberB,
            'https://member-b.example/page',
            'memberb1'
        );

        $response = $this->actingAs($memberA)->get(route('dashboard'));

        $response->assertOk();
        $response->assertSee('https://member-a.example/page');
        $response->assertDontSee('https://member-b.example/page');
    }

    public function test_short_url_redirects_to_original_url(): void
    {
        $company = $this->createCompany('Company A');
        $admin = $this->createUser('admin', $company->id);

        $this->createShortUrl(
            $admin,
            'https://example.com/original-page',
            'testcode'
        );

        $response = $this->get('/s/testcode');

        $response->assertRedirect(
            'https://example.com/original-page'
        );
    }

    
    public function test_superadmin_sees_urls_from_all_companies(): void
    {
        $companyA = $this->createCompany('Company A');
        $companyB = $this->createCompany('Company B');

        $adminA = $this->createUser('admin', $companyA->id);
        $adminB = $this->createUser('admin', $companyB->id);
        $superAdmin = $this->createUser('superadmin');

        $this->createShortUrl(
            $adminA,
            'https://company-a.example/page',
            'companya1'
        );

        $this->createShortUrl(
            $adminB,
            'https://company-b.example/page',
            'companyb1'
        );

        $response = $this->actingAs($superAdmin)
            ->get(route('dashboard'));

        $response->assertOk();
        $response->assertSee('https://company-a.example/page');
        $response->assertSee('https://company-b.example/page');
    }

}
