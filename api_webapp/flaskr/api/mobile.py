import requests
import json
from flask import Blueprint, request

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
        print(json_input)
        genre_preferences = json_input["GenrePreferences"]
        most_voted_genre = max(genre_preferences, key=lambda key: genre_preferences[key])
        list_of_genres = _fetch_genres()
        genre_obj = next((item for item in list_of_genres['genres'] if item['name'] == most_voted_genre), None)
        print(genre_obj["id"])
        genre_id = genre_obj["id"]

        lat = json_input["UserLat"]
        lon = json_input["UserLon"]

        # TODO: Add parameters if needed
        movie_request = 'http://localhost:5000/api/cinemas/movies?location={},{}&distance=5&genre_ids={}'.format(lat, lon, genre_id)

        r = requests.get(movie_request)
        r_json = r.json()
        print(r_json)

        # TODO: format the output


        return r_json
    else:
        error = "An error has occurred: Invalid JSON input. Error code: {}".format(500)
        return error

@bp_mobile_api.route('/cinemas', methods=['POST'])
def get_cinemas():
    # dummy_input = {
    #    "Date": "2020-01-31T17:15:00+01:00",
    #    "MovieId": 27149,
    #    "UserLat": 52.51379,
    #    "UserLon": 13.40342
    # }
    if request.is_json:
        json_input = request.get_json()
        print(json_input)

        lat = json_input["UserLat"]
        lon = json_input["UserLon"]
        movie_id = json_input["MovieId"]
        time_from = json_input["Date"]

        # TODO: Add parameters if needed
        showtime_request = 'http://127.0.0.1:5000/api/cinemas/showtimes?location={},{}&distance=5&&movie_id={}&time_from={}'.format(lat, lon, movie_id, time_from)
        r = requests.get(showtime_request)
        r_json = r.json()

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

        lat = json_input["CinemaLocation"]["lat"]
        lon = json_input["CinemaLocation"]["lon"]

        restaurant_request = 'http://127.0.0.1:5000/api/restaurants/?location={},{}&radius=1000&cuisine={}'.format(lat, lon, most_voted_cuisine)
        r = requests.get(restaurant_request)
        r_json = r.json()

        # Format the output
        results = r_json["results"]
        restaurants = []
        formatted_results = {"Restaurants": []}
        for i,item in enumerate(results):
            json_item = {}
            json_item["lat"] = item.get("geometry").get("location").get("lat")
            json_item["lon"] = item.get("geometry").get("location").get("lng")
            json_item["address"] = item.get("vicinity")
            json_item["id"] = item.get("id")
            json_item["name"] = item.get("name")
            json_item["rating"] = item.get("rating")
            json_item["price_level"] = item.get("price_level")
            json_item["open_now"] = item.get("opening_hours").get("open_now")
            restaurants.append(json_item)

        formatted_results["Restaurants"] = restaurants
        formatted_json = json.dumps(formatted_results)
        return formatted_json
    else:
        error = "An error has occurred: Invalid JSON input. Error code: {}".format(500)
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
    TransportDataDict={
        'ToCinema': list(),
        'ToRestaurant': list()
    }
    CinemaJourneyList=[]
    RestaurantJourneyList=[]

    if request.is_json:
        json_input = request.get_json()

        user_lat = json_input["UserLocation"]["lat"]
        user_lon = json_input["UserLocation"]["lon"]
        user_address = json_input["UserLocation"]["address"]

        cinema_lat = json_input["CinemaLocation"]["lat"]
        cinema_lon = json_input["CinemaLocation"]["lon"]
        cinema_address = json_input["CinemaLocation"]["address"]

        restaurant_lat = json_input["RestaurantLocation"]["lat"]
        restaurant_lon = json_input["RestaurantLocation"]["lon"]
        restaurant_address = json_input["RestaurantLocation"]["address"]

        time_from = json_input["Date"]

        # TODO: Add parameters if needed
        cinema_journey_request = 'http://127.0.0.1:5000/api/transport/journeys?from.location={},{}&from.address={}&to.location={},{}&to.address={}'.format(user_lat, user_lon, user_address,
                                                                                                                                                           cinema_lat, cinema_lon, cinema_address)
        restaurant_journey_request = 'http://127.0.0.1:5000/api/transport/journeys?from.location={},{}&from.address={}&to.location={},{}&to.address={}'.format(cinema_lat, cinema_lon, cinema_address,
                                                                                                                                                               restaurant_lat, restaurant_lon, restaurant_address)

        TocinemaResponse = requests.get(cinema_journey_request)
        ToRestaurantResponse = requests.get(restaurant_journey_request)
        TocinemaResponse_json = TocinemaResponse.json()
        ToRestaurantResponse_json = ToRestaurantResponse.json()

        for journey in TocinemaResponse_json['journeys']:
            leg_len=len(journey['legs'])
            i=1
            for legs in journey['legs']:
                legsdict={}
                legsdict['Step']=i
                k=len(legs)
                if k<=7:
                    if i==leg_len:
                        legsdict['Stop']=legs['origin']['name']
                        legsdict['Destination']=legs['destination']['address']
                    elif i==1:
                        legsdict['Stop']=legs['origin']['address']
                        legsdict['Destination']=legs['destination']['name']    
                    else:
                        legsdict['Destination']=legs['destination']['name']
                        legsdict['Stop']=legs['origin']['name']
                    legsdict['Distance']=legs['distance']
                    legsdict["DepartureTime"]=legs['departure']
                    legsdict['ArrivalTime']=legs['arrival']
                    legsdict['Mode']="Walking"
                if k>7:
                    legsdict['Stop']=legs['origin']['name']
                    legsdict['Destination']=legs['destination']['name']
                    legsdict['ArrivalTime']=legs['arrival']
                    legsdict["DepartureTime"]=legs['departure']
                    legsdict['Direction']=legs["direction"]
                    legsdict["ArrivalPlatform"]=legs["arrivalPlatform"]
                    legsdict["DeparturePlatform"]=legs["departurePlatform"]
                    legsdict['LineName']=legs["line"]["name"]
                    legsdict['Mode']=legs["line"]["mode"]
                i=i+1
                CinemaJourneyList.append(legsdict)
            break 
        for journey in ToRestaurantResponse_json['journeys']:
            leg_len=len(journey['legs'])
            i=1
            for legs in journey['legs']:
                legsdict={}
                legsdict['Step']=i
                k=len(legs)
                if k<=7: # This indicates the walking
                    if i==leg_len:
                        legsdict['Stop']=legs['origin']['name']
                        legsdict['Destination']=legs['destination']['address']
                    elif i==1:
                        legsdict['Stop']=legs['origin']['address']
                        legsdict['Destination']=legs['destination']['name']    
                    else:
                        legsdict['Destination']=legs['destination']['name']
                        legsdict['Stop']=legs['origin']['name']
                    legsdict['Distance']=legs['distance']
                    legsdict["DepartureTime"]=legs['departure']
                    legsdict['ArrivalTime']=legs['arrival']
                    legsdict['Mode']="Walking"
                if k>7: # This is indicate the bus train journey
                    legsdict['Stop']=legs['origin']['name']
                    legsdict['Destination']=legs['destination']['name']
                    legsdict['ArrivalTime']=legs['arrival']
                    legsdict["DepartureTime"]=legs['departure']
                    legsdict['Direction']=legs["direction"]
                    legsdict["ArrivalPlatform"]=legs["arrivalPlatform"]
                    legsdict["DeparturePlatform"]=legs["departurePlatform"]
                    legsdict['LineName']=legs["line"]["name"]
                    legsdict['Mode']=legs["line"]["mode"]
                i=i+1
                RestaurantJourneyList.append(legsdict)
            break       
        TransportDataDict={
        'ToCinema': CinemaJourneyList,
        'ToRestaurant': RestaurantJourneyList
        }
        Trasnport_json=json.dumps(TransportDataDict)
        return Trasnport_json
    else:
        error = "An error has occurred: Invalid JSON input. Error code: {}".format(500)
        return error

def _fetch_genres():
    resp_list_of_genres = requests.get('http://localhost:5000/api/cinemas/list_of_genres')
    return resp_list_of_genres.json()
