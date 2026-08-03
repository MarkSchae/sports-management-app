from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from database import get_db

from schemas.auth_schema import UserCreate, UserLogin, Token

from auth.auth_service import (
    create_user,
    authenticate_user,
    login_user
)

router = APIRouter(prefix="/auth", tags=["Authentication"])

@router.post("/register")
def register(user: UserCreate, db: Session = Depends(get_db)):
    new_user = create_user(
        db,
        user.username,
        user.email,
        user.password
    )
    return new_user


@router.post("/login", response_model=Token)
def login(user: UserLogin, db: Session = Depends(get_db)):
    authenticated_user = authenticate_user(
        db,
        user.email,
        user.password
    )

    if not authenticated_user:
        raise HTTPException(
            status_code=401,
            detail="Invalid credentials"
        )

    token = login_user(
        authenticated_user
    )

    return {
        "access_token": token,
        "token_type": "bearer"
    }