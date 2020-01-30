import requests
import datetime
from flask import Blueprint, request, session

bp_mobile_api = Blueprint('mobile', __name__, url_prefix='/api/mobile')

@bp_mobile_api.route('/movies', methods=['POST'])
def get_movies():
    if request.is_json:
        json_input = request.get_json()
        print(json_input)
        genre_preferences = json_input["GenrePreferences"]
        most_voted_genre = max(genre_preferences, key=lambda key: genre_preferences[key])
        list_of_genres = _fetch_genres()
        genre_obj = next((item for item in list_of_genres['genres'] if item['name'] == most_voted_genre), None)
        print(genre_obj["id"])
        genre_id = genre_obj["id"]

        lat = json_input["UserLat"]
        lon = json_input["UserLon"]

        # Step 2.2x
        movie_request = 'http://localhost:5000/api/cinemas/movies?location={},{}&distance=5&genre_ids={}'.format(lat,
                                                                                                                 lon,
                                                                                                                 genre_id)

        r = requests.get(movie_request)
        r_json = r.json()
        print(r_json)

        # TODO: format the output


        headers = {"Content-type": "application/json"}
        return json_input
    else:
        error = "An error has occurred: Invalid JSON input. Error code: {}".format(500)
        return error

@bp_mobile_api.route('/cinemas', methods=['POST'])
def get_cinemas():
    if request.is_json:
        json_input = request.get_json()
        print(json_input)

        lat = json_input["UserLat"]
        lon = json_input["UserLon"]
        movie_id = json_input["MovieId"]
        time_from = json_input["Date"]

        showtime_request = 'http://127.0.0.1:5000/api/cinemas/showtimes?location={},{}&distance=5&&movie_id={}&time_from={}'.format(lat, lon, movie_id, time_from)

        r = requests.get(showtime_request)
        r_json = r.json()
        print(r_json)
        # TODO: Format the output

        return r_json
    else:
        error = "An error has occurred: Invalid JSON input. Error code: {}".format(500)
        return error

@bp_mobile_api.route('/restaurants', methods=['POST'])
def get_restaurants():
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


def _fetch_genres():
    resp_list_of_genres = requests.get('http://localhost:5000/api/cinemas/list_of_genres')
    return resp_list_of_genres.json()
