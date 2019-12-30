import geocoder
import requests
from flask import Blueprint, request
from flask import jsonify

bp_transport_api = Blueprint('transport', __name__, url_prefix='/api/transport')


# Get journey details by putting longitude and latitude of source and destination, It will return all possible way
# with bus, train schedulr Example: http://127.0.0.1:5000/journey (Note: By deafult I insert latitude and longitude
# manually in the function, Later may be it will take from user)
@bp_transport_api.route('/journey')
def journey():
    url = "https://2.bvg.transport.rest/journeys?from.latitude=52.563630&from.longitude=13.331574&from.address=Gotthardstrasse 96&to.latitude=52.514197&to.longitude=13.326087&to.address=TU%20Berlin&when=1575972000&language=de"
    headers = {"Content-type": "application/json"}
    response = requests.get(url=url, headers=headers)
    if response.status_code == 200:
        rjson = response.json()
        return rjson
    else:
        error = "An error has occured: Refresh again. Error code: {}".format(response.status_code)
        return error


# Get all nearby stops by putting address (e.g: Hoppestrasse 20, Berlin 13409, Germany)
# example: http://127.0.0.1:5000/stops/nearby/Berlin%2013409,%20Hoppestrasse%2017%20Germany
@bp_transport_api.route('/stops/nearby/<address>')
def stops_near_by(address):
    result = geocoder.opencage(address, key='cf361ebaa1374713b8723188837e232e')
    headers = {"Content-type": "application/json"}
    url = "https://2.bvg.transport.rest/stops/nearby?latitude={}&longitude={}".format(result.latlng[0],
                                                                                      result.latlng[1])
    response = requests.get(url=url, headers=headers)
    if response.status_code == 200:
        rjson = response.json()
        return jsonify(rjson)
    else:
        return 'An error has occurred. Refresh it'
#Get the nearby stops using station id
#Example: http://127.0.0.1:5000/api/transport/stops/nearby?id=900000013102
@bp_transport_api.route('/stops/nearby')
def stops_by_id():
    id=request.args.get('id')
    headers = {"Content-type": "application/json"}
    url="https://2.bvg.transport.rest/stops/{}".format(id)
    response = requests.get(url=url, headers=headers)
    if response.status_code == 200:
        rjson = response.json()
        return jsonify(rjson)
    else:
        return 'An error has occurred. Refresh it'
#Get the nearby stops using latitude nad longitude
# Example: http://127.0.0.1:5000/api/transport/stops?latitude=52.52725&longitude=13.4123
@bp_transport_api.route('/stops')
def stops_by_lat_lon():
    latitude=request.args.get('latitude')
    longitude=request.args.get('longitude')
    headers = {"Content-type": "application/json"}
    url="https://2.bvg.transport.rest/stops/nearby?latitude={}&longitude={}".format(latitude,longitude)
    response = requests.get(url=url, headers=headers)
    if response.status_code == 200:
        rjson = response.json()
        return jsonify(rjson)
    else:
        return 'An error has occurred. Refresh it'