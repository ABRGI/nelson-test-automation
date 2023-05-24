from simplegmail import Gmail
import os 
from bs4 import BeautifulSoup

def create_token_file():
    access_token = os.environ["ACCESS_TOKEN"]
    client_id = os.environ["CLIENT_ID"]
    client_secret = os.environ["CLIENT_SECRET"]
    refresh_token = os.environ["REFRESH_TOKEN"]
    token = {
            "access_token": access_token,
            "client_id": client_id,
            "client_secret": client_secret,
            "refresh_token": refresh_token,
            "token_expiry": "2023-05-24T03:49:47Z",
            "token_uri": "https://oauth2.googleapis.com/token",
            "user_agent": "null",
            "revoke_uri": "https://oauth2.googleapis.com/revoke",
            "id_token": "null",
            "id_token_jwt": "null",
            "token_response": {
                "access_token": access_token,
                "expires_in": 3599,
                "refresh_token": refresh_token,
                "scope": "https://www.googleapis.com/auth/gmail.modify https://www.googleapis.com/auth/gmail.settings.basic",
                "token_type": "Bearer"
            },
            "scopes": [
                "https://www.googleapis.com/auth/gmail.modify",
                "https://www.googleapis.com/auth/gmail.settings.basic"
            ],
            "token_info_uri": "https://oauth2.googleapis.com/tokeninfo",
            "invalid": False,
            "_class": "OAuth2Credentials",
            "_module": "oauth2client.client"
        }
    with open ('token.json', 'w') as f:
        f.write(str(token))

def get_messages():
    gmail = auth()
    messages = gmail.get_unread_inbox()
    return messages

def get_link():
    action = 'MANAGE'
    for m in get_messages():
        # Parse data to BeautifulSoup object, which allows easy manipulation
        soup = BeautifulSoup(m.html , "html.parser")
        links = soup.find_all('a', href=True)
        if len(links) > 0:
            for l in links:
                if(action in l.text):
                    return l.attrs['href']
    
def auth():
    if not os.path.exists('gmail_token.json'):
        create_token_file()
    gmail = Gmail()
    return gmail        
        
if __name__ == '__main__':
    l = get_link()
    print(l)