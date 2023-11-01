
from datetime import datetime, timedelta
import requests
import json 
import os 
import json

__version__ = '1.0.0'


class MUIHelpers(object):
    ROBOT_LIBRARY_VERSION = __version__
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'
    
    def __init__(self) -> None:
        self.MUI_USER = os.environ.get('MUI_USER')
        self.MUI_PASSWORD = os.environ.get('MUI_PASSWORD')
        self.ENV_URL = self.set_url()
        self.HOTEL_ID = "3"
        self.token = self.get_token()
    
    def set_url(self):
        if os.environ.get('ENV_URL') is not None:
            self.ENV_URL = os.environ.get('ENV_URL')
        elif os.environ.get('ENV') is not None:
            if os.environ.get('ENV') == "test4":
                self.ENV_URL = "https://test4.omenahotels.com"
            elif os.environ.get('ENV') == "test3":
                self.ENV_URL = "https://test3.omenahotels.com"
            elif os.environ.get("ENV") == 'ectest':
                self.ENV_URL = "https://ectest.omenahotels.com"
        else:
            self.ENV_URL = "https://test3.omenahotels.com"
        
        return self.ENV_URL
    def get_token(self):
        if self.MUI_USER is None or self.MUI_PASSWORD is None:
            raise Exception("MUI_USER or MUI_PASSWORD is not set in the environment variables")
    
        url = "https://admin.nelson.management/api/user/login"
        payload = json.dumps({
        "username": self.MUI_USER,
        "password": self.MUI_PASSWORD
        })
        headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json, text/plain, */*'
        }
        
        response = requests.request("POST", url, headers=headers, data=payload)
        if response.ok:
            return response.json()['token']
        else:
            raise Exception("Login failed with status code: {}".format(response.status_code))

    def get_usage(self, start_date="2023-10-30", end_date="2023-10-31"):
        url = f"{self.ENV_URL}/api/management/secure/hotels/{self.HOTEL_ID}/usage?startDate={start_date}&endDate={end_date}"
        print(url)
        headers = {
        'Authorization': f'Bearer {self.token}'
        }

        response = requests.request("GET", url, headers=headers)
        if response.ok:
            return response.json()
        else:
            raise Exception("Get usage failed with status code: {}".format(response.status_code))
        
    def clean_rooms(self):
        rooms = self.get_usage()
        to_be_cleaned = []
        for room in rooms:
            if room['vacant']:
                to_be_cleaned.append(room['roomId'])
                self.clean_room(int(room['roomId']))
        return to_be_cleaned

    def clean_room(self, room_id):

        url = f"{self.ENV_URL}/api/management/secure/rooms/mark-clean"

        payload = json.dumps(room_id)
        headers = {
        'accept': 'application/json, text/plain, */*',
        'authorization': f'Bearer {self.token}',
        'content-type': 'application/json'
        }

        response = requests.request("POST", url, headers=headers, data=payload)
        if response.ok:
            print(f'Room cleaned with id: {str(room_id)}')

    def mark_dirty(self, room_id):
        
        url = f"{self.ENV_URL}/api/management/secure/rooms/mark-dirty"

        payload = json.dumps(room_id)
        headers = {
        'accept': 'application/json, text/plain, */*',
        'authorization': f'Bearer {self.token}',
        'content-type': 'application/json'
        }

        response = requests.request("POST", url, headers=headers, data=payload)
        if response.ok:
            print(f'Room cleaned with id: {str(room_id)}')       
    
if __name__ == '__main__':
    h = MUIHelpers()
    print(h.clean_rooms())