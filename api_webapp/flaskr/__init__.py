import os
from flask import Flask
from .config import Config, ProductionConfig, DevelopmentConfig
import requests
from flask import jsonify
import geocoder
def create_app(test_config=None):
    # create and configure the app
    app = Flask(__name__, instance_relative_config=True)
    env = os.environ.get("ENV")

    if env is 'production':
        # load the instance config, if it exists, when not testing
        app.config.from_object(DevelopmentConfig())
    elif env is 'development':
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
    # Get journey details by putting longitude and latitude of source and destination, It will return all possible way with bus, train schedulr
    #Example: http://127.0.0.1:5000/journey (Note: By deafult I insert latitude and longitude manually in the function, Later may be it will take from user)
    @app.route('/journey')
    def journey():
        url="https://2.bvg.transport.rest/journeys?from.latitude=52.563630&from.longitude=13.331574&from.address=Gotthardstrasse 96&to.latitude=52.514197&to.longitude=13.326087&to.address=TU%20Berlin&when=1575972000&language=de"
        headers = {"Content-type": "application/json"}
        response = requests.get(url=url, headers=headers)
        if response.status_code==200:
            rjson=response.json()
            return rjson
        else:
            error="An error has occured: Refresh again. Error code: {}".format(response.status_code)
            return error
    #Get all nearby stops by putting address (e.g: Hoppestrasse 20, Berlin 13409, Germany)
    #example: http://127.0.0.1:5000/stops/nearby/Berlin%2013409,%20Hoppestrasse%2017%20Germany
    @app.route('/stops/nearby/<address>')
    def stotsNearby(address):
        result = geocoder.opencage(address, key='cf361ebaa1374713b8723188837e232e')
        headers = {"Content-type": "application/json"}
        url="https://2.bvg.transport.rest/stops/nearby?latitude={}&longitude={}".format(result.latlng[0],result.latlng[1])
        response = requests.get(url=url, headers=headers)
        if response.status_code==200:
            rjson=response.json()
            return jsonify(rjson)
        else:
            return 'An error has occurred. Refresh it'
    from .db import db
    import flaskr.models
    db.init_app(app)
    with app.app_context():
        db.create_all()

    return app
