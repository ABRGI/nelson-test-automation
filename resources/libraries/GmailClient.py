# Imports
from google.auth.transport.requests import Request
from google.oauth2.credentials import Credentials
from google_auth_oauthlib.flow import InstalledAppFlow
from googleapiclient.discovery import build
import base64
import requests
from email.mime.text import MIMEText
import os 

# Base from: https://python.plainenglish.io/how-to-read-write-label-mails-from-gmail-with-python-9695f288f685

class GmailClient():

    def __init__(self) -> None:
        self.SCOPES = ['https://www.googleapis.com/auth/gmail.readonly', 
          'https://www.googleapis.com/auth/gmail.modify']
        self.access_token = os.environ["GMAIL_ACCESS_TOKEN"]
        self.token  = {
            "access_token": self.access_token,
            "expires_in": 3599,
            "refresh_token": os.environ["GMAIL_REFRESH_TOKEN"],
            "scope": "https://www.googleapis.com/auth/gmail.modify https://www.googleapis.com/auth/gmail.readonly",
            "token_type": "Bearer",
            "client_id": os.environ["GMAIL_CLIENT_ID"],
            "client_secret": os.environ["GMAIL_CLIENT_SECRET"],
            }
        self.creds = self.get_creds()
        self.service = build('gmail', 'v1', credentials=self.creds)

    def get_creds(self):
        creds = Credentials.from_authorized_user_info(self.token, self.SCOPES)
        return creds

    def get_email(self):
        em = self.service.users().messages().list(userId="me", maxResults=10).execute()
        return em
    
    def get_latest_email_id_by_subject(self, subject="confirmation"):
        email_id = self.service.users().messages().list(userId='me', q=f'subject: ({subject})', maxResults=1).execute()
        return email_id['messages'][0]['id']

    def get_email_content_by_id(self, email_id):
        message = self.service.users().messages().get(userId='me', id=email_id).execute()
        return message['snippet']

if __name__ == '__main__':
    g = GmailClient()
    print(g.token)
    email_id = g.get_latest_email_id_by_subject("confirmation")

    print(g.get_email_content_by_id(email_id))






