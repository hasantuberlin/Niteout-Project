import requests
import json
from werkzeug.exceptions import BadRequest
from flask import Blueprint, request

bp_cinema_api = Blueprint('cinema', __name__, url_prefix='/api/cinemas')
cinema_api_key = "EDX4mJjrvtFwWe0ZvrZ9NPwRITLTdjuA"
cinema_api_base_url = "https://api.internationalshowtimes.com/v4"


@bp_cinema_api.route('/')
def cinemas():
    params = request.args

    location = params.get('location')
    distance = params.get('distance')
    time_from = params.get('time_from')
    time_to = params.get('time_to')
    movie_id = params.get('movie_id')
    
    url = get_base_url("cinemas")
    url = parse_parameters(url, location, distance, time_from, time_to)
    if movie_id:
        url = url + "&movie_id={}".format(movie_id)

    return get_data(url)


@bp_cinema_api.route('/movies')
def movies():
    params = request.args

    location = params.get('location')  # "52.5154692,13.3242373"
    distance = params.get('distance')
    time_from = params.get('time_from')
    time_to = params.get('time_to')
    movie_id = params.get('movie_id')
    lang = params.get('lang')
    genre_ids = params.get('genre_ids')
    url = get_base_url("movies") + "&all_fields=true"
    url = parse_parameters(url, location, distance, time_from, time_to)
    if movie_id:
        url = url + "&movie_id={}".format(movie_id)
    if lang:
        url = url + "&lang={}".format(lang)
    if genre_ids:
        url = url + "&genre_ids={}".format(genre_ids)

    return get_data(url)


@bp_cinema_api.route('/showtimes')
def showtimes():
    params = request.args

    location = params.get('location')
    distance = params.get('distance')
    time_from = params.get('time_from')
    time_to = params.get('time_to')
    movie_id = params.get('movie_id')
    cinema_id = params.get('cinema_id')

    movie_fields = "id,title,original_title,original_language,runtime,genres,ratings"
    append_info = "cinemas,movies"
    
    url = get_base_url("showtimes") +"&append={}&movie_fields={}&all_fields=true".format(append_info, movie_fields)
    url = parse_parameters(url, location, distance, time_from, time_to)
    if movie_id:
        url = url + "&movie_id={}".format(movie_id)
    if cinema_id:
        url = url + "&cinema_id={}".format(cinema_id)

    return get_data(url)


@bp_cinema_api.route('/list_of_genres')
def list_of_genres():
    url =get_base_url("genres")
    return  get_data(url)

@bp_cinema_api.route('/genres_list')
def predefined_list_of_genres():
    with open('flaskr/api/genres.json',mode='r') as json_file:
        data = json.load(json_file)
        return data

def get_data(url):
    headers = {"Content-type": "application/json"}
    response = requests.get(url=url, headers=headers)
    if response.status_code == 200:
        return response.json()
    else:
        error = "An error has occured: Refresh again. Error code: {}".format(response.status_code)
        return error

def get_base_url(value):
    return "{}/{}/?apikey={}".format(cinema_api_base_url,value,cinema_api_key)

def parse_parameters(url, location, distance, time_from, time_to):
    if parse_location(location):
        url = url + "&location={}".format(location)
    if distance:
        if(parse_float(distance)):
            url = url + "&distance={}".format(distance)
        else:
            raise get_invalid_argument_error("distance")
    if time_from:
        if(parse_datetime(time_from)):
            url = url + "&time_from={}".format(time_from)
        else:
            raise get_invalid_argument_error("time_from")
    if time_to:
        if(parse_datetime(time_to)):
            url = url + "&time_to={}".format(time_to)
        else:
            raise get_invalid_argument_error("time_to")
    return url

def get_parameter_missing_error(parameter):
    return BadRequest("Parameter '{}' is missing in request".format(parameter))

def get_invalid_argument_error(parameter):
    return BadRequest("Parameter '{}' is invalid".format(parameter))

def parse_location(location):
    if location:
        locations = location.split(',')
        if (type(locations) is list and 
            len(locations) == 2 and 
            parse_float(locations[0]) and 
            parse_float(locations[1])):
            return True
        else:
            raise get_invalid_argument_error("location") 
    else:
        raise get_parameter_missing_error("location")

def parse_float(value):
    try:
        float(value)
        return True
    except:
        return False

def parse_datetime(location):
    try:
        datetime.datetime.fromisoformat(location)
        return True
    except:
        return False