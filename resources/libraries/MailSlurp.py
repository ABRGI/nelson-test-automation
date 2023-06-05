import mailslurp_client
import re
import os
from robot.api.deco import keyword
from bs4 import BeautifulSoup

# define a library to use mailslurp functions in robot test
class MailSlurp(object):
    ROBOT_LIBRARY_VERSION = '1.0.0'
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'

    # configure the mailslurp client using your API KEY
    def __init__(self):
        self.ms_api_key = self.set_api_key()
        self.configuration = mailslurp_client.Configuration()
        self.configuration.api_key['x-api-key'] = self.ms_api_key


    def set_api_key(self):
        ms_api_key = os.environ.get('MAILSLURP_API_KEY')
        if ms_api_key == None:
            raise Exception("MAILSLURP_API_KEY environment variable is not set")
        return ms_api_key
    
    # function for creating an email address returns an inbox with an id and email_address
    def create_new_inbox(self):
        with mailslurp_client.ApiClient(self.configuration) as api_client:
            # create an inbox using the inbox controller
            api_instance = mailslurp_client.InboxControllerApi(api_client)
            inbox = api_instance.create_inbox()
            return inbox

    def wait_for_latest_email(self, inbox_id):
        with mailslurp_client.ApiClient(self.configuration) as api_client:
            # create an inbox using the inbox controller
            api_instance = mailslurp_client.WaitForControllerApi(api_client)
            email = api_instance.wait_for_latest_email(inbox_id=inbox_id, timeout=60000, unread_only=True)
            return email

    @keyword("Extract Link")
    def extract_link(self, email_body, action='MANAGE'):
        soup = BeautifulSoup(email_body , "html.parser")
        links = soup.find_all('a', href=True)
        if len(links) > 0:
            for l in links:
                if(action in l.text):
                    return l.attrs['href']
        

if __name__ == '__main__':
    m = MailSlurp()
    email=m.create_new_inbox()
    html = '''
    <html>
        <a href="link">MANAGE</a>
        <a href="link">SOMETHING</a>
    </html>
    '''
    api_key = "3b12b09cc897c651b281343b8fb2daeef311b6e343ba984b11a374c70b66dd60"
    link =m.extract_link(email_body=html)