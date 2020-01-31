# WebApp for Backend API

## Instructions for executing application
- Install python packages through pip `requirements.txt` file <br>
`pip install -r requirements.txt`
- (Optional) Change database credentials in `flaskr/config.py`
- Execute `startApp.sh` file

## List Of Available Endpoints
| Endpoint | Explanation | Parameters | Output |
|----------|-------------|------------|--------|
| `/api/transport/journey` | Returns a json with information about transports in several parts, indicated by the mode of transportation | None | Json |
| `/api/transport/stops/nearby?id=` | Returns a json with all nearby stopage information | id of the stops| Json |
| `/api/transport/stops?latitude=&longitude=` | Returns a json with all nearby stopage information | latitude,longitude | Json |

## Transportation API
### `GET /api/transport/journeys`
- `from.location` (string) **Required** <br>
The latitude/longitude around which to retrieve departure place information. <br>
**Example**:  52.5154692,13.3242373

- `from.address` (string) **Required** <br>
The address around which to retrieve departure place information. <br>
**Example**:  Einsteinufer 17

- `to.location` (string) **Required** <br>
The latitude/longitude around which to retrieve arrival place information. <br>
**Example**: 52.5081878,13.3730181

- `to.address` (string) **Required** <br>
The address around which to retrieve arrival place information. <br>
**Example**: Potsdamer Straße 5

- `departure` (string) <br>
Departure time <br>
**Time format**: Any parsable date-time string should work, however ISO8601 as in RFC3339 is recommended. <br>
**Example**:  2020-01-27T17:15:00+01:00

- `arrival` (string) <br>
Arrival time <br>
**Time format**: Any parsable date-time string should work, however ISO8601 as in RFC3339 is recommended. <br>
**Example**:  2020-01-27T17:15:00+01:00

- `suburban` (string - default: true) <br>
Include S-Bahn trains? <br>
**Example**: true

- `subway` (string - default: true) <br>
Include U-Bahn trains? <br>
**Example**: true

- `tram` (string - default: true) <br>
Include trams? <br>
**Example**: false

- `bus` (string - default: true) <br>
Include buses? <br>
**Example**: false

- `express` (string - default: true) <br>
Include IC/ICE/EC trains? <br>
**Example**: false

- `regional` (string - default: true) <br>
Include RE/RB/ODEG trains? <br>
**Example**: true

#### Example
`http://127.0.0.1:5000/api/transport/journeys?from.location=52.5154692,13.3242373&from.address=Einsteinufer%2017&to.location=52.5081878,13.3730181&to.address=Potsdamer%20Stra%C3%9Fe%205&departure=2020-01-27T17:15:00&subway=false`

## Cinema API
### `GET /api/cinemas`
- `location` (string) **Required** <br>
Retrieve cinemas in a particular area by passing a geo loaction as center in the format latitude,longitude. <br>
**Example**:  52.5154692,13.3242373

- `distance` (number - default: 20 - maximum: 50) <br>
For retrieving cinemas in a particular area along with the location you may want to specify the maximum distance given in kilometers. Results will be sorted by distance in ascending order. <br>
**Example**:  5

- `time_from` (string - default: beginning of today in UTC timezone) <br>
Filters the list of cinemas to those having showtimes at the given point in time or later. <br>
**Hint**: Only in combination with movie_id. <br>
**Time format**: Any parsable date-time string should work, however ISO8601 as in RFC3339 is recommended. <br>
**Example**:  2020-01-27T17:15:00+01:00

- `time_to` (string - default: infinity) <br>
Filters the list of cinemas to those having showtimes at the given point in time or earlier. <br>
**Hint**: Only in combination with movie_id. <br>
**Time format**: Any parsable date-time string should work, however ISO8601 as in RFC3339 is recommended. <br>
**Example**:  2020-01-27T17:15:00+01:00

- `movie_id`(string) <br>
Filter the cinemas to those having showtimes for a selected movie. <br>
Hint: Should be use in combination with `time_from` and `time_to`.

#### Example
`http://127.0.0.1:5000/api/cinemas/?location=52.5154692,13.3242373&distance=5`

### `GET /api/cinemas/movies`
- `location` (string) **Required** <br>
Retrieve cinemas in a particular area by passing a geo loaction as center in the format latitude,longitude. <br>
**Example**:  52.5154692,13.3242373

- `distance` (number - default: 20 - maximum: 50) <br>
For retrieving cinemas in a particular area along with the location you may want to specify the maximum distance given in kilometers. Results will be sorted by distance in ascending order. <br>
**Example**:  5

- `time_from` (string - default: beginning of today in UTC timezone) <br>
Filters the list of cinemas to those having showtimes at the given point in time or later. <br>
**Hint**: Only in combination with movie_id. <br>
**Time format**: Any parsable date-time string should work, however ISO8601 as in RFC3339 is recommended. <br>
**Example**:  2020-01-27T17:15:00+01:00

- `time_to` (string - default: infinity) <br>
Filters the list of cinemas to those having showtimes at the given point in time or earlier. <br>
**Hint**: Only in combination with movie_id. <br>
**Time format**: Any parsable date-time string should work, however ISO8601 as in RFC3339 is recommended. <br>
**Example**:  2020-01-27T17:15:00+01:00

- `movie_id`(string) <br>
Filter the cinemas to those having showtimes for a selected movie. <br>
Hint: Should be use in combination with `time_from` and `time_to`.

- `lang`(string) <br>
Specifies the language for the resource's content given as an ISO 639 locale code. <br>
**Example**:  en

- `genre_ids`(string) <br>
Filters movies to being in any of the specified genres. <br>
**Example**:  1,2,3

#### Example
`http://127.0.0.1:5000/api/cinemas/movies?location=52.5154692,13.3242373&distance=5`

### `GET /api/cinemas/showtimes`
- `location` (string) **Required** <br>
Retrieve cinemas in a particular area by passing a geo loaction as center in the format latitude,longitude. <br>
**Example**:  52.5154692,13.3242373

- `distance` (number - default: 20 - maximum: 50) <br>
For retrieving cinemas in a particular area along with the location you may want to specify the maximum distance given in kilometers. Results will be sorted by distance in ascending order. <br>
**Example**:  5

- `time_from` (string - default: beginning of today in UTC timezone) <br>
Filters the list of cinemas to those having showtimes at the given point in time or later. <br>
**Hint**: Only in combination with movie_id. <br>
**Time format**: Any parsable date-time string should work, however ISO8601 as in RFC3339 is recommended. <br>
**Example**:  2020-01-27T17:15:00+01:00

- `time_to` (string - default: infinity) <br>
Filters the list of cinemas to those having showtimes at the given point in time or earlier. <br>
**Hint**: Only in combination with movie_id. <br>
**Time format**: Any parsable date-time string should work, however ISO8601 as in RFC3339 is recommended. <br>
**Example**:  2020-01-27T17:15:00+01:00

- `movie_id`(string) <br>
Filter showtimes by movie_id to either a particular movie or absence/presence of a movie. <br>
**Hint**: Showtimes may not be linked to a movie in case of them being published with a title that the system fails to find a unique movie for. 
This is most likely the case for events held in cinemas, which are not showing an actual movie. <br>
**Filtering null values**: To retrieve only showtimes linked to a movie simply set the value of this parameter to !null. Likewise set it to null for retrieving only showtimes without linked movie. <br>
**Example**:  27149

- `cinema_id`(string) <br>
Retrieve showtimes for a particular cinema. <br>
**Example**:  1

#### Example
`http://127.0.0.1:5000/api/cinemas/showtimes?location=52.5154692,13.3242373&distance=3&movie_id=27149`

## Restaurant API
### `GET /api/restaurants`
- `location` (string) **Required** <br>
The latitude/longitude around which to retrieve place information. <br>
**Hint** : If you specify a `location` parameter, you must also specify a `radius` parameter. <br>
**Example**:  52.5154692,13.3242373

- `radius` (number - maximum: 50000) <br>
Defines the distance (in meters) within which to bias place results. <br>
**Example**:  1000

- `cuisine` (string) <br>
Filter restaurants by cuisine type. <br>
**Example**: asian

- `minprice` and `maxprice` (number - minimum: 0 - maximum: 4) <br>
Restricts results to only those places within the specified price level. Valid values are in the range from 0 (most affordable) to 4 (most expensive), inclusive. <br>
**Example**: 2

#### Example
`http://127.0.0.1:5000/api/restaurants/?location=52.5154692,13.3242373&radius=1000&cuisine=asian&maxprice=2`
