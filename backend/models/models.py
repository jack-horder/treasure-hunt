import os
from typing import Annotated

from fastapi import Depends
from sqlmodel import SQLModel, Session, Field
from sqlalchemy import create_engine, event
from sqlalchemy.engine.interfaces import DBAPIConnection

sqlite_uri = os.getenv("SQLALCHEMY_DATABASE_URI", "sqlite:///project.db")

connect_args = {"check_same_thread": False}
engine = create_engine(sqlite_uri, connect_args=connect_args)


def create_db_and_tables():
    SQLModel.metadata.create_all(engine)


def get_session():
    with Session(engine) as session:
        yield session


SessionDep = Annotated[Session, Depends(get_session)]


@event.listens_for(engine, "connect")
def set_sqlite_pragma(dbapi_connection: DBAPIConnection, _):
    cursor = dbapi_connection.cursor()
    cursor.execute("PRAGMA journal_mode=WAL")
    cursor.execute("PRAGMA synchronous=NORMAL")
    cursor.close()


class Hero(SQLModel, table=True):
    id: int | None = Field(default=None, primary_key=True)
    name: str = Field(index=True)
    age: int | None = Field(default=None, index=True)
    secret_name: str
