# Sembark URL Shortener

A multi-company URL shortener application built with **Laravel 12, PHP, and MySQL/SQLite**. The application supports role-based access control, company-level data isolation, invitation-based onboarding, and public short URL redirection.

## Features

- **Authentication:** Secure login and logout.
- **Multi-company support:** Each company has its own users and short URLs.
- **Role-based access control:** SuperAdmin, Admin, and Member roles.
- **Invitation system:** Invite users to join a company.
- **Short URL creation:** Admins and Members can create short URLs.
- **Access restrictions:** SuperAdmins cannot create short URLs.
- **Company-level visibility:** Admins can view URLs belonging to their company.
- **User-level visibility:** Members can view only the URLs they created.
- **Global visibility:** SuperAdmins can view short URLs across all companies.
- **Public redirection:** Short URLs redirect visitors to their original URLs.
- **Automated tests:** Feature tests cover URL creation, access permissions, data visibility, and redirection.

## Technology Stack

- PHP 8.2+
- Laravel 12
- MySQL or SQLite
- Blade templates
- Laravel Eloquent ORM
- PHPUnit / Laravel testing tools

## Requirements

Before installation, make sure you have:

- PHP 8.2 or a compatible newer version
- Composer
- MySQL or SQLite
- Node.js and npm, if you need to build frontend assets

## Installation

### 1. Clone the repository

```bash
git clone https://github.com/guptashubhu/sembark-url-shortener.git
cd sembark-url-shortener
```

### 2. Install PHP dependencies

```bash
composer install
```

### 3. Configure the environment

Create your local environment file.

On Windows:

```powershell
Copy-Item .env.example .env
```

Generate the application key:

```bash
php artisan key:generate
```

### 4. Configure the database

For MySQL, update the database settings in `.env`:

```env
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=sembark_url_shortener
DB_USERNAME=root
DB_PASSWORD=
```

Create the `sembark_url_shortener` database in MySQL before running migrations. Update the username and password according to your local setup.

Alternatively, configure SQLite in `.env` and ensure the SQLite database file exists.

### 5. Run migrations and seed the database

```bash
php artisan migrate --seed
```

This creates the required database tables and seeds the SuperAdmin account.

**Important:** Use the SuperAdmin credentials configured in the seeder for local development. Change the default password before using the application in any shared or production environment. Never commit real credentials or secrets to GitHub.

### 6. Install frontend dependencies

If required by the frontend setup:

```bash
npm install
npm run build
```

### 7. Start the application

```bash
php artisan serve
```

Open the local URL displayed in your terminal, usually:

`http://127.0.0.1:8000`

## User Roles and Permissions

| Feature | SuperAdmin | Admin | Member |
|---|---|---|---|
| View short URLs across all companies | Yes | No | No |
| View URLs from own company | All companies | Yes | Own URLs only |
| Create short URLs | No | Yes | Yes |
| Invite an Admin | Yes | Yes, within own company | No |
| Invite a Member | No | Yes, within own company | No |

SuperAdmin can invite an Admin while creating a company. Admins can invite Admins or Members into their own company.

Invitations are accepted through an invitation link. In the current development flow, the generated link is displayed by the application; automatic email delivery is not claimed as an implemented feature.

## Running Tests

Run all automated tests:

```bash
php artisan test
```

To run the short URL feature tests:

```bash
php artisan test --filter=ShortUrlTest
```

The ShortUrlTest suite currently contains seven passing tests covering:

- Admin can create a short URL.
- Member can create a short URL.
- SuperAdmin cannot create a short URL.
- Admin sees URLs from their own company.
- Member sees only their own URLs.
- Public short URL redirects to the original URL.
- SuperAdmin sees URLs from all companies.

## Project Structure

```text
app/
  Http/
    Controllers/
      InvitationController.php
      ShortUrlController.php
    Middleware/
      RoleMiddleware.php
  Models/
    Company.php
    Invitation.php
    ShortUrl.php
    User.php

database/
  migrations/
  seeders/

resources/
  views/
    dashboard.blade.php
    invitations/

routes/
  web.php

tests/
  Feature/
    ShortUrlTest.php
```

## Security Considerations

- Routes are protected using authentication and role-based middleware.
- Short URL listings are scoped according to user role and company.
- Invitation tokens are stored as hashes and invitations expire.
- Passwords are hashed before storage.
- Keep `.env` and all production credentials out of version control.

## AI Assistance Disclosure

AI tools were used to assist with development, debugging, test preparation, and documentation. The implementation was reviewed and tested during development. The project author should be able to explain the code, design decisions, permissions, database relationships, and test cases.

## License

This project was developed as a technical assignment. No separate project license has been specified.
