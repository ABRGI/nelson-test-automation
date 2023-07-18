import requests
import json
import os 

# Set the authorization token
token = os.environ.get("MUI_TOKEN")

def get_rooms(start_date, end_date, hotel):
    availability_url = f"{base_url}/api/management/secure/hotels/{hotel}/usage?startDate={start_date}&endDate={end_date}"

    params = {
        "startDate": start_date,
        "endDate": end_date
    }
    headers = {
        "Authorization": f"Bearer {token}"
    }
    response = requests.get(availability_url, params=params, headers=headers)
    rooms = response.json()
    print(rooms)
    ids = []
    for room in rooms:
        if room["available"]:
            ids.append(room["roomId"])
    return ids

def clean_rooms(start_date, end_date, hotel):
    rooms = get_rooms(start_date, end_date, hotel)
    for room in rooms:
        r = int(room)
        payload = json.dumps(r)
        url = f"{base_url}/api/management/secure/rooms/mark-clean"
        headers = {
            "Authorization": f"Bearer {token}",
            "Content-Type": "application/json"
        }
        response = requests.post(url, data=payload, headers=headers)
        assert response.ok

base_url = "https://test3.omenahotels.com"
start_date = "2023-07-16"
end_date = "2023-07-31"
hotel = "3"
clean_rooms(start_date, end_date, hotel)