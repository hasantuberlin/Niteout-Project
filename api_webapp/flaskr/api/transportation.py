import geocoder
import requests
import time
from flask import Blueprint, request
from flask import jsonify

bp_transport_api = Blueprint('transport', __name__, url_prefix='/api/transport')


# Get journey details by putting longitude and latitude of source and destination, It will return all possible way
# with bus, train schedulr Example: http://127.0.0.1:5000/journey (Note: By deafult I insert latitude and longitude
# manually in the function, Later may be it will take from user)
@bp_transport_api.route('/journeys')
def journeys():
    params = request.args

    # Required
    from_latitude = params.get('from.location').split(',')[0]
    from_longitude = params.get('from.location').split(',')[1]
    from_address = params.get('from.address')

    to_latitude = params.get('to.location').split(',')[0]
    to_longitude = params.get('to.location').split(',')[1]
    to_address = params.get('to.address')

    if not from_latitude or not from_longitude or not from_address:
        error = "Invalid from.type: location"
        return error

    if not to_latitude or not to_longitude or not to_address:
        error = "Invalid to.type: location"
        return error

    url = "https://2.bvg.transport.rest/journeys?from.latitude={}&from.longitude={}&from.address={}&to.latitude={}&to.longitude={}&to.address={}".format(from_latitude, from_longitude, from_address,
                                                                                                                                                         to_latitude, to_longitude, to_address)

    # Optional
    departure = params.get('departure')
    arrival = params.get('arrival')
    suburban = params.get('suburban')
    subway = params.get('subway')
    tram = params.get('tram')
    bus = params.get('bus')
    express = params.get('express')
    regional = params.get('regional')
    results = params.get('results')

    if departure:
        tuple_time = time.strptime(departure[:19], "%Y-%m-%dT%H:%M:%S")
        unix_time = str(time.mktime(tuple_time)).split('.')[0]
        url = url + "&departure={}".format(unix_time)
    if arrival:
        tuple_time = time.strptime(arrival[:19], "%Y-%m-%dT%H:%M:%S")
        unix_time = str(time.mktime(tuple_time)).split('.')[0]
        url = url + "&arrival={}".format(unix_time)
    if suburban:
        url = url + "&suburban={}".format(suburban)
    if subway:
        url = url + "&subway={}".format(subway)
    if tram:
        url = url + "&tram={}".format(tram)
    if bus:
        url = url + "&bus={}".format(bus)
    if express:
        url = url + "&express={}".format(express)
    if regional:
        url = url + "&regional={}".format(regional)
    if results:
        url = url + "&results={}".format(results)
        
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