import os

# You need to replace the next values with the appropriate values for your configuration

basedir = os.path.abspath(os.path.dirname(__file__))
SQLALCHEMY_ECHO = False
SQLALCHEMY_TRACK_MODIFICATIONS = True
SQLALCHEMY_DATABASE_URI = "postgresql://desmond:admin@localhost/productivity_app"

# Change username and password
# ------------------------------------------------------------------
# backend -> source env/bin/activate
# CREATE ROLE USERNAME_HERE WITH SUPERUSER PASSWORD 'PASSWORD_HERE';
# ALTER ROLE USERNAME_HERE WITH LOGIN;
# ------------------------------------------------------------------