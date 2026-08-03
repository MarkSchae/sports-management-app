from sqlalchemy.orm import Session

from models.user_roles import User
from auth.security import hash_password, verify_password, create_access_token


def create_user(db: Session, username: str, email: str, password: str):
    hashed_password = hash_password(password)

    user = User(
        username=username,
        email=email,
        hashed_password=hashed_password
    )

    db.add(user)
    db.commit()
    db.refresh(user)

    return user


def authenticate_user(db: Session, email: str, password: str):
    user = (
        db.query(User)
        .filter(User.email == email)
        .first()
    )

    if not user:
        return None

    if not verify_password(password, user.hashed_password):
        return None

    return user


def login_user(user):
    token = create_access_token({"sub": str(user.id), "role": str(user.role)})

    return token