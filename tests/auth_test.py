from auth.security import (
    hash_password,
    verify_password,
    create_access_token,
)


def test_password_hashing():
    password = "mysecretpassword"

    hashed = hash_password(password)

    assert hashed != password
    assert verify_password(password, hashed)


def test_create_token():
    data = {
        "sub": "user123"
    }

    token = create_access_token(data)

    assert token is not None
    assert isinstance(token, str)