import requests
import datetime
from flask import Blueprint, request

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
        most_voted_genre_id = 0

        lat = json_input["UserLat"]
        lon = json_input["UserLon"]

        # Step 2.2x
        movie_request = 'http://localhost:5000/api/cinemas/movies?location={},{}&distance=5&genre_ids={}'.format(lat,
                                                                                                                 lon,
                                                                                                                 most_voted_genre_id)

        r = requests.get(movie_request)
        r_json = r.json()
        print(r_json)

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
        headers = {"Content-type": "application/json"}
        return json_input
    else:
        error = "An error has occurred: Invalid JSON input. Error code: {}".format(500)
        return error
