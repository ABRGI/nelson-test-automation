from __future__ import print_function

import os.path

from google.auth.transport.requests import Request
from google.oauth2.credentials import Credentials
from google_auth_oauthlib.flow import InstalledAppFlow
from googleapiclient.discovery import build
from googleapiclient.errors import HttpError
import pickle
import base64
import email
from bs4 import BeautifulSoup
# If modifying these scopes, delete the file token.json.


SCOPES = ['https://www.googleapis.com/auth/gmail.readonly']

def connect():
    creds = None
    # The file token.json stores the user's access and refresh tokens, and is
    # created automatically when the authorization flow completes for the first
    # time.
    if os.path.exists('token.json'):
        creds = Credentials.from_authorized_user_file('token.json', SCOPES)
    # If there are no (valid) credentials available, let the user log in.
    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            flow = InstalledAppFlow.from_client_secrets_file(
                'credentials.json', SCOPES)
            creds = flow.run_local_server(port=0)
        # Save the credentials for the next run
        with open('token.json', 'w') as token:
            token.write(creds.to_json())

    try:
        # Call the Gmail API
        service = build('gmail', 'v1', credentials=creds)
        return service
    except HttpError as error:
        # TODO - Handle errors from gmail API.
        print(f'An error occurred: {error}')

def get_messages():
    """ Gets messages from Gmail
    """
    service = connect()
    results = service.users().messages().list(userId='me').execute()
    messages = results.get('messages')
    return messages, service


# TODO: Refactor and split into smaller functions
def get_link(action='MANAGE', search_term='Booking confirmation'):
    messages, service = get_messages()
    for m in messages:
        txt = service.users().messages().get(userId='me', id=m['id']).execute()
        try:
            payload = txt['payload']
            headers = payload['headers']

            for d in headers:
                if d['name'] == 'Subject':
                    subject = d['value']
                if d['name'] == 'From':
                    sender = d['value']

            # Decrypt email parts
            parts = payload.get('parts')
            if search_term in subject:
            # Currently only works for MANAGE 
            # TODO: Create common usage
            
                if len(parts) > 0: 
                    for part in parts:
                        if 'multipart' in part['mimeType']:
                            part = part['parts'][1]
                        if 'data' in part['body']:
                            data = part['body']['data']
                            data = data.replace("-","+").replace("_","/")
                            decoded_data = base64.b64decode(data)
                            # Parse data to BeautifulSoup object, which allows easy manipulation
                            soup = BeautifulSoup(decoded_data , "html.parser")
                            links = soup.find_all('a', href=True)
                            if len(links) > 0:
                                for l in links:
                                    if(action in l.text):
                                        return l.attrs['href']

                            
        except Exception as e:
            print('Exception', e)
            # TODO: Handle exceptions 
        
if __name__ == '__main__':
    link = get_link('MANAGE')
    print(link)

