import requests
import datetime
from flask import Blueprint, request

bp_mobile_api = Blueprint('mobile', __name__, url_prefix='/api/mobile')
cinema_api_key = "EDX4mJjrvtFwWe0ZvrZ9NPwRITLTdjuA"


@bp_mobile_api.route('/movies', methods=['POST'])
def cinemas():
    if request.is_json:
        json_input = request.get_json()
        print(json_input)
        most_voted_cuisine = max(json_input["GenrePreferences"].iterkeys(), key=(lambda key: json_input["GenrePreferences"][key]))
        print(most_voted_cuisine)
        headers = {"Content-type": "application/json"}
        return json_input
    else:
        error = "An error has occurred: Invalid JSON input. Error code: {}".format(500)
        return error