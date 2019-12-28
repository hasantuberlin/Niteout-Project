# WebApp for Backend API

## Instructions for executing application
- Install python packages through pip `requirements.txt` file
- Either install postgres SQL separately or use `docker-compose.yml` file present to launch a postgres instance
- Change database credentials in `flaskr/config.py`
- Execute `startApp.sh` file

## List Of Available Endpoints
| Endpoint | Explanation | Parameters | Output |
|----------|-------------|------------|--------|
| `/api/transport/journey` | Returns a json with information about transports in several parts, indicated by the mode of transportation | None | Json |
