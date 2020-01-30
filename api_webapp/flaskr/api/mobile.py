import requests
import datetime
from flask import Blueprint, request, session

bp_mobile_api = Blueprint('mobile', __name__, url_prefix='/api/mobile')
cinema_api_key = "EDX4mJjrvtFwWe0ZvrZ9NPwRITLTdjuA"


@bp_mobile_api.route('/movies', methods=['POST'])
def movies():
    if request.is_json:
        json_input = request.get_json()
        print(json_input)
        genre_preferences = json_input["GenrePreferences"]
        most_voted_genre = max(genre_preferences, key=lambda key: genre_preferences[key])
        print(most_voted_genre)
        list_of_genres = _fetch_genres()
        genre_obj = next((item for item in list_of_genres['genres'] if item['name'] == most_voted_genre), None)
        print(genre_obj)
        headers = {"Content-type": "application/json"}
        return json_input
    else:
        error = "An error has occurred: Invalid JSON input. Error code: {}".format(500)
        return error


@bp_mobile_api.route('/restaurants', methods=['POST'])
def restaurants():
    if request.is_json:
        json_input = request.get_json()
        print(json_input)
        cuisine_preferences = json_input["CuisinePreferences"]
        most_voted_cuisine = max(cuisine_preferences, key=lambda key: cuisine_preferences[key])
        print(most_voted_cuisine)
        print(g.list_of_genres)
        headers = {"Content-type": "application/json"}
        return json_input
    else:
        error = "An error has occurred: Invalid JSON input. Error code: {}".format(500)
        return error


def _fetch_genres():
    resp_list_of_genres = requests.get('http://localhost:5000/api/cinemas/list_of_genres')
    return resp_list_of_genres.json()
