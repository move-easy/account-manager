# AccountManager

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Endpoints
>[!IMPORTANT]
>
> All routes have some type of authentication.

### Create User

- **Router:** [POST] `/api/users`
- **Payload:**
```json
  {
      "username": "test",
      "document": "17599376502",
      "phone": "27999999999",
      "age": 24,
      "password": "123456&",
      "email": "test@gmail.com",
      "zip_code": "11111111",
      "state_acronym": "ES"
  }
```
- **Response:**
1. Success [status code 201]
```json
{
    "data": {
        "message": "User created successfully!",
        "profile": "user",
        "username": "test",
        "email": "test@gmail.com",
        "is_active": true,
        "access_token": "SFMyNTY.g2gDdAAAAAN3B3Byb2ZpbGVtAAAABHVzZXJ3BWVtYWlsbQAAAA50ZXN0QGdtYWlsLmNvbXcJaXNfYWN0aXZldwR0cnVlbgYAwW5is48BYgABUYA.8bBr2GsjK7SCz0SgNUsELDaIR3pPQMYPhMDkg9aSWzQ"
    }
}
```
2. Errors [status code 422]
```json
{
    "errors": {
        "email": [
            "has already been taken"
        ]
    }
}
```
or
```json
{
    "errors": {
        "password": [
            "should be at least 6 character(s)"
        ],
        "email": [
            "has invalid format"
        ],
        "document": [
            "should be at least 11 character(s)"
        ]
    }
}
```
3. Error [status code 401]
```json
{
    "erros": {
        "message": "Unauthorized"
    }
}
```

## User Retrival
- **Router:* [GET] `/api/users` or `/api/users?email=email@gmail.com`
- **Response:**
1. Success [status code 200]
```json
{
    "data": {
        "message": "User retrieved successfully!",
        "profile": "user",
        "username": "oteixeiras",
        "email": "oteixeiras@gmail.com",
        "is_active": true
    }
}
```
2. Error [status code 404]
```json
{
    "erros": {
        "message": "Resource not found"
    }
}
```
3. Error [status code 401]
```json
{
    "erros": {
        "message": "Unauthorized"
    }
}
```

## User Authentication
- **Router:** [POST] `/api/users/login`
- **Payload:**
```json
{
    "password": "string",
    "email": "string"
}
```
- **Response:**
1. Success [status code 200]
```json
{
    "data": {
        "message": "User authenticated successfully!",
        "profile": "user",
        "username": "oteixeiras",
        "email": "oteixeiras@gmail.com",
        "is_active": true,
        "access_token": "SFMyNTY.g2gDdAAAAAN3B3Byb2ZpbGVtAAAABHVzZXJ3BWVtYWlsbQAAABRvdGVpeGVpcmFzQGdtYWlsLmNvbXcJaXNfYWN0aXZldwR0cnVlbgYAqlVVs48BYgABUYA.APDpM7TDxFvo47JKD7W0IoOFh3TGxB6xxvpNqlPGdDE"
    }
}
```
2. Error [status code 404]
```json
{
    "erros": {
        "message": "Resource not found"
    }
}
```

3. Error [status code 401]
```json
{
    "erros": {
        "message": "Unauthorized"
    }
}
```

## Delete of user
- **Router:** [DELETE] `/api/users`
- **Payload:**
```json
{
    "email": "oteixeiras@gmail.com"
}
```
- **Response:**
1. Success [status code 200]
```json
{
    "data": {
        "message": "User deleted successfully!",
        "profile": "user",
        "username": "oteixeiras",
        "email": "oteixeiras@gmail.com"
        "is_active": true
    }
}
```
2. Error [status code 401]
```json
{
    "erros": {
        "message": "Unauthorized"
    }
}
```

3. Error [status code 404]
```json
{
    "erros": {
        "message": "Resource not found"
    }
}
```

4. Error [status code 405]
```json
{
    "erros": {
        "message": "Method not allowed"
    }
}
```
>[!TIP]
> [status code 405]
> Trying to remove the logged in user.

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
