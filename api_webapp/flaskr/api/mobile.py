import requests
from flask import Blueprint, request, jsonify
from datetime import datetime, timedelta
import time

bp_mobile_api = Blueprint('mobile', __name__, url_prefix='/api/mobile')


@bp_mobile_api.route('/movies', methods=['POST'])
def get_movies():
    # dummy_input = {
    #    "Date": "2020-01-31T17:15:00+01:00",
    #    "GenrePreferences": {
    #       "Action": 10,
    #       "Comedy": 5,
    #       "Romantic": 7,
    #       "Fiction": 8,
    #       "Horror": 1
    #    },
    #    "UserLat": 52.51379,
    #    "UserLon": 13.40342
    # }
    if request.is_json:
        json_input = request.get_json()
        genre_preferences = json_input["GenrePreferences"]
        most_voted_genre = max(
            genre_preferences, key=lambda key: genre_preferences[key])
        list_of_genres = _fetch_genres()
        genre_obj = next(
            (item for item in list_of_genres['genres'] if item['name'] == most_voted_genre), None)
        genre_id = genre_obj["id"]

        lat = json_input["UserLat"]
        lon = json_input["UserLon"]

        movie_request = 'http://localhost:5000/api/cinemas/movies?location={},{}&distance=5&genre_ids={}'.format(lat,
                                                                                                                 lon,
                                                                                                                 genre_id)

        r = requests.get(movie_request)
        r_json = r.json()

        results = r_json["movies"]
        movies = []
        formatted_results = {"Movies": []}
        for item in results:
            json_item = {}
            json_item["movie_id"] = item.get("id")
            json_item["title"] = item.get("title")
            json_item["poster"] = item.get("poster_image_thumbnail", "")
            json_item["genres"] = item.get("genres")
            # workaround on ratings
            ratings = item.get("ratings")
            if ratings:
                json_item["ratings"] = ratings[next(
                    iter(ratings))].get("value")
            else:
                json_item["ratings"] = ""
            json_item["runtime"] = item.get("runtime")
            movies.append(json_item)

        formatted_results["Movies"] = movies
        formatted_json = jsonify(formatted_results)
        return formatted_json
    else:
        error = "An error has occurred: Invalid JSON input. Error code: {}".format(
            500)
        return error


@bp_mobile_api.route('/showtimes', methods=['POST'])
def get_showtimes():
    # dummy_input = {
    #    "Date": "2020-01-31T17:15:00+01:00",
    #    "MovieId": 27149,
    #    "UserLat": 52.51379,
    #    "UserLon": 13.40342
    # }
    if request.is_json:
        json_input = request.get_json()

        lat = json_input["UserLat"]
        lon = json_input["UserLon"]
        movie_id = json_input["MovieId"]
        time_from = json_input["Date"]

        # TODO: Add parameters if needed
        showtime_request = 'http://127.0.0.1:5000/api/cinemas/showtimes?location={},{}&distance=3&movie_id={}&time_from={}'.format(
            lat, lon, movie_id, time_from)
        r = requests.get(showtime_request)
        r_json = r.json()

        # TODO: Format the output
        cinemas_results = r_json["cinemas"]
        cinemas = []
        for item in cinemas_results:
            json_item = {"lat": item.get("location").get("lat"), "lon": item.get("location").get("lon"),
                         "address": item.get("location").get("address").get("display_text"), "id": item.get("id"),
                         "name": item.get("name")}
            cinemas.append(json_item)

        showtimes_results = r_json["showtimes"]
        showtimes = []
        for item in showtimes_results:
            json_item = {"cinema_id": item.get("cinema_id"), "cinema_movie_title": item.get("cinema_movie_title"),
                         "movie_id": item.get("movie_id"), "is_3d": item.get("is_3d"), "is_imax": item.get("is_imax"),
                         "language": item.get("language"), "start_at": item.get("start_at"),
                         "subtitle_language": item.get("subtitle_language")}
            showtimes.append(json_item)

        formatted_results = {"Cinemas": cinemas, "Showtimes": showtimes}
        formatted_json = jsonify(formatted_results)
        return formatted_json
    else:
        error = "An error has occurred: Invalid JSON input. Error code: {}".format(
            500)
        return error


@bp_mobile_api.route('/restaurants', methods=['POST'])
def get_restaurants():
    if request.is_json:
        json_input = request.get_json()

        cuisine_preferences = json_input["CuisinePreferences"]
        most_voted_cuisine = max(
            cuisine_preferences, key=lambda key: cuisine_preferences[key])

        lat = json_input["CinemaLocation"].get("lat", "")
        lon = json_input["CinemaLocation"].get("lon", "")

        restaurant_request = 'http://127.0.0.1:5000/api/restaurants/?location={},{}&radius=1000&cuisine={}'.format(lat,
                                                                                                                   lon,
                                                                                                                   most_voted_cuisine)
        r = requests.get(restaurant_request)
        r_json = r.json()

        # Format the output
        results = r_json["results"]
        restaurants = []
        formatted_results = {"Restaurants": []}
        for item in results:
            json_item = {"lat": item.get("geometry").get("location").get("lat"),
                         "lon": item.get("geometry").get("location").get("lng"),
                         "address": item.get("vicinity"),
                         "id": item.get("id"),
                         "name": item.get("name"),
                         "rating": item.get("rating"),
                         "price_level": item.get("price_level")}
            if(item.get("opening_hours") != None):
                json_item["open_now"] = item.get(
                    "opening_hours").get("open_now")
            else:
                json_item["open_now"] = ""
            if(json_item["open_now"] == True):
                restaurants.append(json_item)

        formatted_results["Restaurants"] = restaurants
        formatted_json = jsonify(formatted_results)
        return formatted_json
    else:
        error = "An error has occurred: Invalid JSON input. Error code: {}".format(
            500)
        return error


@bp_mobile_api.route('/journeys', methods=['POST'])
def get_journeys():
    # dummy_input = {
    #    "Date": "2020-01-31T17:15:00+01:00",
    #    "CinemaLocation": {
    #    		"lat": 52.5059,
    #    		"lon": 13.3331,
    #    		"address": "Hardenbergstraße 29A, 10623 Berlin"
    #    },
    #    "RestaurantLocation": {
    #    		"lat": 52.5062864,
    #    		"lon": 13.3178534,
    #    		"address": "Kantstraße 30, Berlin"
    #    },
    #    "UserLocation":{
    #    		"lat": 52.51379,
    #    		"lon": 13.40342,
    #    		"address": "Brüderstraße"
    #    }
    # }
    TransportDataDict = {
        'ToCinema': list(),
        'ToRestaurant': list()
    }

    if request.is_json:
        json_input = request.get_json()

        user_lat = json_input["UserLocation"].get("lat", "")
        user_lon = json_input["UserLocation"].get("lon", "")
        user_address = json_input["UserLocation"].get("address", "")

        cinema_lat = json_input["CinemaLocation"].get("lat", "")
        cinema_lon = json_input["CinemaLocation"].get("lon", "")
        cinema_address = json_input["CinemaLocation"].get("address", "")

        restaurant_lat = json_input["RestaurantLocation"].get("lat", "")
        restaurant_lon = json_input["RestaurantLocation"].get("lon", "")
        restaurant_address = json_input["RestaurantLocation"].get(
            "address", "")

        time_from = json_input["Date"]
        toCinemaResponse = call_transportaion_api(
            "cinema", user_lat, user_lon, user_address, cinema_lat, cinema_lon, cinema_address, time_from)

        # Add buffer to the second connection departure
        time_from_dt = datetime.strptime(time_from[:19], "%Y-%m-%dT%H:%M:%S")
        time_from2 = time_from_dt + timedelta(hours=2, minutes=30)
        time_from2 = time_from2.strftime('%Y-%m-%dT%H:%M:%S')

        toRestaurantResponse = call_transportaion_api(
            "resturant", cinema_lat, cinema_lon, cinema_address, restaurant_lat, restaurant_lon, restaurant_address, time_from2)

        cinema_journey = parse_transportation_api_output(
            toCinemaResponse.json())
        restraurant_journey = parse_transportation_api_output(
            toRestaurantResponse.json())
        TransportDataDict = {
            'ToCinema': cinema_journey,
            'ToRestaurant': restraurant_journey
        }
        Trasnport_json = jsonify(TransportDataDict)
        return Trasnport_json
    else:
        error = "An error has occurred: Invalid JSON input. Error code: {}".format(
            500)
        return error


def call_transportaion_api(label, from_lat, from_lon, from_address, to_lat, to_lon, to_address, time_from):
    # Error handling caused by unresponsive BVG API
    max_retries = 10
    num_retries = 0
    base_url = "http://127.0.0.1:5000/api/transport/journeys"
    response = {}
    while num_retries < max_retries:
        url = "{}?from.location={},{}&from.address={}&to.location={},{}&to.address={}&departure={}".format(
            base_url, from_lat, from_lon, from_address, to_lat, to_lon, to_address, time_from)
        response = requests.get(url)
        if response.content != b'An error has occured: Refresh again. Error code: 502':
            return response
        num_retries += 1
        time.sleep(1)
    if num_retries == max_retries:
        error = "An error has occurred on fetching {} journey response: Refresh again. Error code: {}".format(
            label, response.status_code)
        return error
    return response


def parse_transportation_api_output(input_json):
    journeys = get_journeys_from_json(input_json)
    journeys.sort(key= lambda k: int(k["TravelTime"]))
    output = {}
    # i = 1
    # for journey in journeys:
    #     output[i] = journey
    #     i += 1
    first = journeys[0]
    output[1] = first
    return output


def get_journeys_from_json(input_json):
    journeys = []
    for journey in input_json['journeys']:
        journeyList = []
        leg_len = len(journey['legs'])
        i = 1
        for legs in journey['legs']:
            legsdict = {}
            # traveltime={}
            legsdict['Step'] = i
            k = len(legs)
            if k <= 7:  # This indicates the walking
                if i == leg_len:
                    legsdict['Stop'] = legs['origin']['name']
                    legsdict['Destination'] = legs['destination']['address']
                    endingtime = legs['arrival']
                    endingtime = endingtime[:endingtime.index("+")]
                    endingtime = datetime.strptime(
                        endingtime, '%Y-%m-%dT%H:%M:%S')
                    diff = endingtime-starttime
                    diff = ((diff).total_seconds())/60
                    # traveltime["TravelTime"]=diff
                    # journeyList.append(traveltime)
                elif i == 1:
                    legsdict['Stop'] = legs['origin']['address']
                    legsdict['Destination'] = legs['destination']['name']
                    starttime = legs['departure']
                    starttime = starttime[:starttime.index("+")]
                    starttime = datetime.strptime(
                        starttime, '%Y-%m-%dT%H:%M:%S')
                else:
                    legsdict['Destination'] = legs['destination']['name']
                    legsdict['Stop'] = legs['origin']['name']
                legsdict['Distance'] = legs.get('distance', '')
                legsdict["DepartureTime"] = legs['departure']
                legsdict['ArrivalTime'] = legs['arrival']
                legsdict['Mode'] = "Walking"
            if k > 7:  # This indicates the (bus train) journey
                legsdict['Stop'] = legs['origin']['name']
                legsdict['Destination'] = legs['destination']['name']
                legsdict['ArrivalTime'] = legs['arrival']
                legsdict["DepartureTime"] = legs['departure']
                legsdict['Direction'] = legs.get('direction', '')
                #legsdict["ArrivalPlatform"] = legs.get('arrivalPlatform', '')
                #legsdict["DeparturePlatform"] = legs.get('departurePlatform', '')
                legsdict['LineName'] = legs["line"]["name"]
                legsdict['Mode'] = legs["line"]["mode"]
            i += 1
            journeyList.append(legsdict)
        journey = {
            "Journey": journeyList,
            "TravelTime": diff
        }
        journeys.append(journey)
    return journeys


def _fetch_genres():
    resp_list_of_genres = requests.get(
        'http://localhost:5000/api/cinemas/list_of_genres')
    return resp_list_of_genres.json()
