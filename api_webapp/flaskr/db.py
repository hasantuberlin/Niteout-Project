from flask_sqlalchemy import SQLAlchemy
import flask

app = flask.Flask(__name__)
db = SQLAlchemy()
