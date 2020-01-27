import requests
from flask import Blueprint, request

bp_cinema_api = Blueprint('cinema', __name__, url_prefix='/api/cinemas')
cinema_api_key = "EDX4mJjrvtFwWe0ZvrZ9NPwRITLTdjuA"


@bp_cinema_api.route('/')
def cinemas():
    params = request.args

    location = params.get('location')
    distance = params.get('distance')
    time_from = params.get('time_from')
    time_to = params.get('time_to')
    movie_id = params.get('movie_id')

    url = "https://api.internationalshowtimes.com/v4/cinemas/?apikey={}".format(cinema_api_key)
    if location:
        url = url + "&location={}".format(location)
    if distance:
        url = url + "&distance={}".format(distance)
    if time_from:
        url = url + "&time_from={}".format(time_from)
    if time_to:
        url = url + "&time_to={}".format(time_to)
    if movie_id:
        url = url + "&movie_id={}".format(movie_id)

    headers = {"Content-type": "application/json"}
    response = requests.get(url=url, headers=headers)
    if response.status_code == 200:
        rjson = response.json()
        return rjson
    else:
        error = "An error has occured: Refresh again. Error code: {}".format(response.status_code)
        return error

@bp_cinema_api.route('/movies')
def movies():
    params = request.args

    location = params.get('location') # "52.5154692,13.3242373"
    distance = params.get('distance')
    time_from = params.get('time_from')
    time_to = params.get('time_to')
    movie_id = params.get('movie_id')
    lang = params.get('lang')
    genre_ids = params.get('genre_ids')

    url = "https://api.internationalshowtimes.com/v4/movies/?apikey={}&all_fields=true".format(cinema_api_key)
    if location:
        url = url + "&location={}".format(location)
    if distance:
        url = url + "&distance={}".format(distance)
    if time_from:
        url = url + "&time_from={}".format(time_from)
    if time_to:
        url = url + "&time_to={}".format(time_to)
    if movie_id:
        url = url + "&movie_id={}".format(movie_id)
    if lang:
        url = url + "&lang={}".format(lang)
    if genre_ids:
        url = url + "&genre_ids={}".format(genre_ids)

    headers = {"Content-type": "application/json"}
    response = requests.get(url=url, headers=headers)
    if response.status_code == 200:
        rjson = response.json()
        return rjson
    else:
        error = "An error has occured: Refresh again. Error code: {}".format(response.status_code)
        return error

@bp_cinema_api.route('/showtimes')
def showtimes():
    params = request.args

    location = params.get('location')
    distance = params.get('distance')
    time_from = params.get('time_from')
    time_to = params.get('time_to')
    movie_id = params.get('movie_id')
    cinema_id = params.get('cinema_id')
    genre_ids = params.get('genre_ids')

    movie_fields = "id,title,original_title,original_language,runtime,genres,ratings"
    append_info = "cinemas,movies"

    url = "https://api.internationalshowtimes.com/v4/showtimes/?apikey={}&append={}&movie_fields={}&all_fields=true".format(cinema_api_key, append_info, movie_fields)
    if location:
        url = url + "&location={}".format(location)
    if distance:
        url = url + "&distance={}".format(distance)
    if time_from:
        url = url + "&time_from={}".format(time_from)
    if time_to:
        url = url + "&time_to={}".format(time_to)
    if movie_id:
        url = url + "&movie_id={}".format(movie_id)
    if cinema_id:
        url = url + "&cinema_id={}".format(cinema_id)

    headers = {"Content-type": "application/json"}
    response = requests.get(url=url, headers=headers)
    if response.status_code == 200:
        rjson = response.json()
        return rjson
    else:
        error = "An error has occured: Refresh again. Error code: {}".format(response.status_code)
        return error