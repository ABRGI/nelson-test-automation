import mailslurp_client
import re
import os
from robot.api.deco import keyword
from bs4 import BeautifulSoup
from mailslurp_client.api.email_controller_api import EmailControllerApi
from mailslurp_client.api.inbox_controller_api import InboxControllerApi

# define a library to use mailslurp functions in robot test
class MailSlurp(object):
    ROBOT_LIBRARY_VERSION = '1.0.0'
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'

    # configure the mailslurp client using your API KEY
    def __init__(self):
        self.configuration = mailslurp_client.Configuration()
        self.configuration.api_key['x-api-key'] = os.environ.get('MAILSLURP_API_KEY')
        self.api_client = mailslurp_client.ApiClient(self.configuration)
        self.email_client = mailslurp_client.EmailControllerApi(self.api_client)
    
    # function for creating an email address returns an inbox with an id and email_address
    @keyword("Create new Inbox")
    def create_new_inbox(self):
        with mailslurp_client.ApiClient(self.configuration) as api_client:
            # create an inbox using the inbox controller
            api_instance = mailslurp_client.InboxControllerApi(api_client)
            inbox = api_instance.create_inbox()
            return inbox
        
    @keyword("Wait for Latest Email")
    def wait_for_latest_email(self, inbox_id):
        with mailslurp_client.ApiClient(self.configuration) as api_client:
            api_instance = mailslurp_client.WaitForControllerApi(api_client)
            email = api_instance.wait_for_latest_email(inbox_id=inbox_id, timeout=60000, unread_only=True)
            return email

    @keyword("Wait for Latest Booking Confirmation")
    def wait_for_latest_booking_confirmation(self, inbox_id):
        search_text="confirmation"
        with mailslurp_client.ApiClient(self.configuration) as api_client:
            api_instance = mailslurp_client.WaitForControllerApi(api_client)
            match_options = {'matches': [{'field': 'SUBJECT','should':'CONTAIN','value':f'{search_text}'}]}
            emails = api_instance.wait_for_matching_emails(inbox_id=inbox_id, match_options=match_options, timeout=60000, unread_only=False, count=2)
            for e in emails:
                # TODO: currently only checks for the sender, needs to be changed when environments are set up
                if 'noreply-test4' in e._from:
                    email = self.email_client.get_email_html(email_id=e.id)
                    return email
        
    @keyword("Extract Link")
    def extract_link(self, email_body, action='MANAGE'):
        soup = BeautifulSoup(email_body , "html.parser")
        links = soup.find_all('a', href=True)
        if len(links) > 0:
            for l in links:
                if(action in l.text):
                    return l.attrs['href']
        

