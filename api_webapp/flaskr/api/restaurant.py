import requests
from flask import Blueprint, request

bp_restaurant_api = Blueprint('restaurant', __name__, url_prefix='/api/restaurants')
restaurant_api_key = "AIzaSyA8YmjIPCPcOerJOuO4tzFbQ1eoJ6W6ilw"


@bp_restaurant_api.route('/')
def restaurants():
    params = request.args

    location = params.get('location') # "52.5154692,13.3242373"
    radius = params.get('radius')
    cuisine = params.get('cuisine')

    url = "https://maps.googleapis.com/maps/api/place/textsearch/json?key={}&type=restaurant".format(restaurant_api_key)
    if location:
        url = url + "&location={}".format(location)
    if radius:
        url = url + "&radius={}".format(radius)
    if cuisine:
        url = url + "&query={}+restaurant".format(cuisine)

    headers = {"Content-type": "application/json"}
    response = requests.get(url=url, headers=headers)
    if response.status_code == 200:
        rjson = response.json()
        return rjson
    else:
        error = "An error has occured: Refresh again. Error code: {}".format(response.status_code)
        return error