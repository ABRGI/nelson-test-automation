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
    # 76f2cba58fc827f5252020446f37f7f1fe736b20de1b03df48e5d77c5231ef91
    # configure the mailslurp client using your API KEY
    def __init__(self):
        self.configuration = mailslurp_client.Configuration()
        self.configuration.api_key['x-api-key'] = os.environ.get('MAILSLURP_API_KEY')
        self.api_client = mailslurp_client.ApiClient(self.configuration)
        self.email_client = mailslurp_client.EmailControllerApi(self.api_client)
              
    @keyword("Get All Inboxes")
    def get_all_inboxes(self):
        with mailslurp_client.ApiClient(self.configuration) as api_client:
            # create an inbox using the inbox controller
            api_instance = mailslurp_client.InboxControllerApi(api_client)
            inbox = api_instance.get_all_inboxes()
            return inbox
            
    # function for creating an email address returns an inbox with an id and email_address
    @keyword("Create new Inbox")
    def create_new_inbox(self):
        print('Debug Config')
        print(self.configuration)
        with mailslurp_client.ApiClient(self.configuration) as api_client:
            # create an inbox using the inbox controller
            api_instance = mailslurp_client.InboxControllerApi(api_client)
            inbox = api_instance.create_inbox()
            print(inbox)
            print(self)
            return inbox
    
    @keyword("Get Inbox")
    def get_inbox(self, inbox_id):
        with mailslurp_client.ApiClient(self.configuration) as api_client:
            api_instance = mailslurp_client.InboxControllerApi(api_client)
            inbox = api_instance.get_inbox(inbox_id)
            print(inbox.name)
            return inbox
        
    @keyword("Wait for Latest Email")
    def wait_for_latest_email(self, inbox_id):
        with mailslurp_client.ApiClient(self.configuration) as api_client:
            api_instance = mailslurp_client.WaitForControllerApi(api_client)
            email = api_instance.wait_for_latest_email(inbox_id=inbox_id, timeout=60000, unread_only=True)
            return email

    @keyword("Wait for Latest Booking Confirmation")
    def wait_for_latest_booking_confirmation(self, inbox_id="492aa3bb-9e4b-410a-a02c-84f13ace89e8", search_text="Booking confirmation"):
        with mailslurp_client.ApiClient(self.configuration) as api_client:
            api_instance = mailslurp_client.WaitForControllerApi(api_client)
            match_options = {'matches': [{'field': 'SUBJECT','should':'CONTAIN','value':f'{search_text}'}]}
            emails = api_instance.wait_for_matching_emails(inbox_id=inbox_id, match_options=match_options, timeout=60000, unread_only=False, count=1)
            for e in emails:
                email = self.email_client.get_email_html(email_id=e.id)
                return email
        
    @keyword("Extract Link")
    def extract_link(self, email_body, action='manage-booking'):
        soup = BeautifulSoup(email_body , "html.parser")
        links = soup.find_all('a', href=True)
        if len(links) > 0:
            for l in links:
                if(action in l.attrs['href']):
                    return l.attrs['href']
        
    @keyword("Get Confirmation Number from Email")
    def get_confirmation_number_from_email(self, email):
        soup = BeautifulSoup(email , "html.parser")
        td = soup.find_all('td')[5]
        bno = td.string
        bno = bno.strip()
        return bno
    
    @keyword("Wait for Latest Booking Confirmation and Extract Link")
    def wait_for_latest_booking_confirmation_and_extract_link(self, inbox_id="492aa3bb-9e4b-410a-a02c-84f13ace89e8"):
        body = self.wait_for_latest_booking_confirmation(inbox_id)
        link = self.extract_link(body)
        return link

if __name__ == '__main__':
    m = MailSlurp()
    i = m.create_new_inbox()
    #inbox_id = "efc7c87b-8bcf-4ad9-bb4e-c5c459b2d526"


    link = m.wait_for_latest_booking_confirmation_and_extract_link()
    print(link)
    #e = m.wait_for_latest_booking_confirmation('492aa3bb-9e4b-410a-a02c-84f13ace89e8', 'Welcome to Exhibition')
    #bn = m.get_confirmation_number_from_email(e)
    

