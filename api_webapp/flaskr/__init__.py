import os

from flask import Flask

from .config import Config, ProductionConfig, DevelopmentConfig


def create_app(test_config=None):
    # create and configure the app
    app = Flask(__name__, instance_relative_config=True)
    env = os.environ.get("ENV")

    if env == 'production':
        # load the instance config, if it exists, when not testing
        app.config.from_object(DevelopmentConfig())
    elif env == 'development':
        # load the instance config, if it exists, when not testing
        app.config.from_object(DevelopmentConfig())
    else:
        # load the test config if passed in
        # app.config.from_mapping(test_config)
        app.config.from_object(Config())

    # ensure the instance folder exists
    try:
        os.makedirs(app.instance_path)
    except OSError:
        pass

    # a simple page that says hello
    @app.route('/')
    def welcome():
        return 'Welcome to NiteOut Application!'

    # a simple page that says hello
    @app.route('/hello')
    def hello():
        return 'Hello, World!'

    # Import blueprint of transportation API
    from .api import bp_transport_api, bp_cinema_api, bp_restaurant_api, bp_mobile_api

    # Register blueprint of transportation API
    app.register_blueprint(bp_transport_api)
    app.register_blueprint(bp_cinema_api)
    app.register_blueprint(bp_restaurant_api)
    app.register_blueprint(bp_mobile_api)

    return app
