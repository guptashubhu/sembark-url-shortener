
<!DOCTYPE html>
<html>
<head>
    <title>Accept Invitation</title>
</head>
<body>
    <h1>Accept Invitation</h1>

    <p>Email: {{ $invitation->email }}</p>
    <p>Role: {{ $invitation->role }}</p>

    @if ($errors->any())
        <ul>
            @foreach ($errors->all() as $error)
                <li>{{ $error }}</li>
            @endforeach
        </ul>
    @endif

    <form method="POST"
          action="{{ route('invitations.accept.submit', ['token' => $token]) }}">
        @csrf

        <div>
            <label>Name</label>
            <input type="text" name="name"
                   value="{{ old('name') }}" required>
        </div>

        <div>
            <label>Password</label>
            <input type="password" name="password" required>
        </div>

        <div>
            <label>Confirm Password</label>
            <input type="password"
                   name="password_confirmation" required>
        </div>

        <button type="submit">Create Account</button>
    </form>
</body>
</html>
