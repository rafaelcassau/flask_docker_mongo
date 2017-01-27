import os


class Config(object):
    SECRET_KEY = os.environ['SECRET_KEY']
    DEBUG = os.environ['DEBUG']

    MONGODB_HOST = os.environ['MONGODB_HOST']
    MONGODB_PORT = int(os.environ['MONGODB_PORT'])
    MONGODB_DB = os.environ['MONGODB_DB']
    # MONGODB_USERNAME = os.environ['MONGODB_USERNAME']
    # MONGODB_PASSWORD = os.environ['MONGODB_PASSWORD']