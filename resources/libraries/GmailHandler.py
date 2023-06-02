from simplegmail import Gmail
import os 
from bs4 import BeautifulSoup
import json 
from robot.api.deco import keyword


class GmailHandler():
    
    def __init__(self):

        self.access_token = os.environ["ACCESS_TOKEN"]
        self.client_id = os.environ["CLIENT_ID"]
        self.client_secret = os.environ["CLIENT_SECRET"]
        self.refresh_token = os.environ["REFRESH_TOKEN"]
        self.client_secrets = self.set_client_secret()
        self.client_tokens = self.set_client_token()
        self.gmail = Gmail()
        self.new_messages = self.gmail.get_unread_inbox()
        
    def set_client_secret(self):
        secrets = {
            "installed":
            {
                "client_id": self.client_id,
                "project_id": "omenahotels",
                "auth_uri": "https://accounts.google.com/o/oauth2/auth",
                "token_uri": "https://oauth2.googleapis.com/token",
                "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
                "client_secret": self.client_secret,
                "redirect_uris": ["http://localhost"]
            }
        }
        if not os.path.exists('client_secret.json'):
            with open('client_secret.json', 'w') as f:
                f.write(json.dumps(secrets))
        else:
            print('client_secret.json already exists')
    
    def set_client_token(self):
        token = {
                "access_token": self.access_token,
                "client_id": self.client_id,
                "client_secret": self.client_secret,
                "refresh_token": self.refresh_token,
                "token_expiry": "2026-05-24T13:30:06Z",
                "token_uri": "https://oauth2.googleapis.com/token",
                "user_agent": None,
                "revoke_uri": "https://oauth2.googleapis.com/revoke",
                "id_token": None,
                "id_token_jwt": None,
                "token_response": {
                    "access_token": self.access_token,
                    "expires_in": 3599,
                    "refresh_token": self.refresh_token,
                    "scope": "https://www.googleapis.com/auth/gmail.modify https://www.googleapis.com/auth/gmail.settings.basic",
                    "token_type": "Bearer"
                },
                "scopes": [
                    "https://www.googleapis.com/auth/gmail.settings.basic",
                    "https://www.googleapis.com/auth/gmail.modify"
                ],
                "token_info_uri": "https://oauth2.googleapis.com/tokeninfo",
                "invalid": False,
                "_class": "OAuth2Credentials",
                "_module": "oauth2client.client"
        }
        if not os.path.exists('gmail_token.json'):
            with open('gmail_token.json', 'w') as f:
                f.write(json.dumps(token))
        else: 
            print('gmail_token.json already exists')

    @keyword("Get Link")
    def get_link(self, action='MANAGE'):
        #    create_token_file()
        for m in self.new_messages:
            # Parse data to BeautifulSoup object, which allows easy manipulation
            soup = BeautifulSoup(m.html , "html.parser")
            links = soup.find_all('a', href=True)
            if len(links) > 0:
                for l in links:
                    if(action in l.text):
                        return l.attrs['href']
        
        
        
if __name__ == '__main__':
    g = GmailHandler()
    l = g.get_link()
    