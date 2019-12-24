import os

basedir = os.path.abspath(os.path.dirname(__file__))


class Config(object):
    DEBUG = False
    TESTING = False
    CSRF_ENABLED = True
    SECRET_KEY = b'E\xf2v\xe4Qd;\x15\x8ba\x92\xe2\x05Q\x05d'
    SQLALCHEMY_DATABASE_URI = "sqlite:///:memory:"  # os.environ['DATABASE_URL']
    SQLALCHEMY_TRACK_MODIFICATIONS = True


class ProductionConfig(Config):
    DEBUG = False
    SQLALCHEMY_DATABASE_URI = "sqlite:///:memory:"  # os.environ['DATABASE_URL']


class DevelopmentConfig(Config):
    DEVELOPMENT = True
    DEBUG = True
    SQLALCHEMY_DATABASE_URI = "postgresql://niteout_admin:pwd0123456789@localhost:54320/niteout_app_db"
