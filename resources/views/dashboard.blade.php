
<x-app-layout>
    <x-slot name="header">
        <div>
            @if (auth()->user()->role === 'superadmin')
                <h2 class="text-xl font-semibold text-purple-700">
                    Super Admin Panel
                </h2>
            @elseif (auth()->user()->role === 'admin')
                <h2 class="text-xl font-semibold text-blue-700">
                    Admin Panel
                </h2>
            @elseif (auth()->user()->role === 'member')
                <h2 class="text-xl font-semibold text-green-700">
                    Member Panel
                </h2>
            @endif
        </div>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white shadow-sm sm:rounded-lg">
                <div class="p-6 text-gray-900">

                    {{-- Success message --}}
                    @if (session('success'))
                        <p class="text-green-600 mb-4">
                            {{ session('success') }}
                        </p>
                    @endif

                    {{-- Invitation link --}}
                    @if (session('invite_url'))
                        <div class="mb-4 p-3 bg-green-100 rounded">
                            <p class="font-bold">Invitation created!</p>

                            <a href="{{ session('invite_url') }}"
                               class="text-blue-600 underline break-all">
                                {{ session('invite_url') }}
                            </a>

                            <p class="text-sm mt-2">
                                Open this link in another browser or incognito window.
                            </p>
                        </div>
                    @endif

                    {{-- Validation errors --}}
                    @if ($errors->any())
                        <div class="mb-4 text-red-600">
                            @foreach ($errors->all() as $error)
                                <p>{{ $error }}</p>
                            @endforeach
                        </div>
                    @endif

                    {{-- Invitation form: SuperAdmin and Admin only --}}
                    @if (in_array(auth()->user()->role, ['superadmin', 'admin']))
                        <h3 class="text-lg font-semibold mb-3">
                            Invite a User
                        </h3>

                        <form method="POST" action="{{ route('invitations.store') }}">
                            @csrf

                            @if (auth()->user()->role === 'superadmin')
                                <div class="mb-4">
                                    <label for="company_name">Company Name</label>

                                    <input
                                        id="company_name"
                                        type="text"
                                        name="company_name"
                                        value="{{ old('company_name') }}"
                                        required
                                        class="border rounded p-2 w-full"
                                    >
                                </div>
                            @endif

                            <div class="mb-4">
                                <label for="email">Invitee Email</label>

                                <input
                                    id="email"
                                    type="email"
                                    name="email"
                                    value="{{ old('email') }}"
                                    required
                                    class="border rounded p-2 w-full"
                                >
                            </div>

                            <div class="mb-4">
                                <label for="role">Role</label>

                                <select
                                    id="role"
                                    name="role"
                                    required
                                    class="border rounded p-2 w-full"
                                >
                                    @if (auth()->user()->role === 'superadmin')
                                        <option value="admin">Admin</option>
                                    @else
                                        <option value="member">Member</option>
                                        <option value="admin">Admin</option>
                                    @endif
                                </select>
                            </div>

                            <button
                                type="submit"
                                class="bg-blue-600 rounded px-4 py-2"
                            >
                                Create Invitation
                            </button>
                        </form>
                    @endif

                    {{-- URL creation: Admin and Member only --}}
                    @if (in_array(auth()->user()->role, ['admin', 'member']))
                        <hr class="my-6">

                        <h3 class="text-lg font-semibold mb-3">
                            Create Short URL
                        </h3>

                        <form method="POST" action="{{ route('shorturls.store') }}">
                            @csrf

                            <div class="mb-4">
                                <label for="original_url">Original URL</label>

                                <input
                                    id="original_url"
                                    type="url"
                                    name="original_url"
                                    value="{{ old('original_url') }}"
                                    placeholder="https://example.com/page"
                                    required
                                    class="border rounded p-2 w-full"
                                >
                            </div>

                            <button
                                type="submit"
                                class="bg-blue-600 rounded px-4 py-2"
                            >
                                Shorten URL
                            </button>
                        </form>
                    @endif

                    {{-- URL listing: all roles --}}
                    <hr class="my-6">

                    <h3 class="text-lg font-semibold mb-4">
                        Short URLs
                    </h3>

                    @if ($shortUrls->isEmpty())
                        <p class="text-gray-600">
                            No short URLs found.
                        </p>
                    @else
                        <div class="overflow-x-auto">
                            <table class="w-full border-collapse border">
                                <thead>
                                    <tr class="bg-gray-100">
                                        <th class="border p-3 text-left">
                                            Original URL
                                        </th>

                                        <th class="border p-3 text-left">
                                            Short URL
                                        </th>

                                        @if (auth()->user()->role !== 'member')
                                            <th class="border p-3 text-left">
                                                Created By
                                            </th>

                                            <th class="border p-3 text-left">
                                                Company
                                            </th>
                                        @endif

                                        <th class="border p-3 text-left">
                                            Created At
                                        </th>
                                    </tr>
                                </thead>

                                <tbody>
                                    @foreach ($shortUrls as $shortUrl)
                                        <tr>
                                            <td class="border p-3 break-all">
                                                {{ $shortUrl->original_url }}
                                            </td>

                                            <td class="border p-3 break-all">
                                                <a
                                                    href="{{ route('shorturls.redirect', ['code' => $shortUrl->code]) }}"
                                                    target="_blank"
                                                    class="text-blue-600 underline"
                                                >
                                                    {{ route('shorturls.redirect', ['code' => $shortUrl->code]) }}
                                                </a>
                                            </td>

                                            @if (auth()->user()->role !== 'member')
                                                <td class="border p-3">
                                                    {{ $shortUrl->user->name }}
                                                </td>

                                                <td class="border p-3">
                                                    {{ $shortUrl->company->name }}
                                                </td>
                                            @endif

                                            <td class="border p-3">
                                                {{ $shortUrl->created_at->format('d M Y') }}
                                            </td>
                                        </tr>
                                    @endforeach
                                </tbody>
                            </table>
                        </div>
                    @endif

                </div>
            </div>
        </div>
    </div>
</x-app-layout>
