import mailslurp_client
import re
import os
from robot.api.deco import keyword
from bs4 import BeautifulSoup
from mailslurp_client.api.email_controller_api import EmailControllerApi
from mailslurp_client.api.inbox_controller_api import InboxControllerApi
from dotenv import load_dotenv
import csv
import pandas as pd
# define a library to use mailslurp functions in robot test
class MailSlurp(object):
    ROBOT_LIBRARY_VERSION = '1.0.0'
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'
    # configure the mailslurp client using your API KEY
    def __init__(self):
        self.configuration = mailslurp_client.Configuration()
        self.configuration.api_key['x-api-key'] = self.set_api_key()
        self.api_client = mailslurp_client.ApiClient(self.configuration)
        self.email_client = mailslurp_client.EmailControllerApi(self.api_client)
        self.domains =  ['test.kensingtonstay.com', 'test4.omenahotels.com', 'test3.omenahotels.com']
        self.nelson_forward = "35ac21dc-e785-4cad-8949-6f32023a286d"
        self.nelson_test = "492aa3bb-9e4b-410a-a02c-84f13ace89e8"
        self.temp_csv = 'temp.csv'
        self.output_csv = 'links.csv'
        
    def set_api_key(self):
        try:
            key = os.environ.get('MAILSLURP_API_KEY')
            if key == None:
                print("Mailslurp Key not Found")
                try:
                    load_dotenv()
                    key = os.getenv('MAILSLURP_API_KEY')
                    if key != None:
                        print('Found key from dotenv')
                except Exception as e:
                    print(e)
        except Exception as e:
            print(e)
        return key
        
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
    def wait_for_latest_booking_confirmation(self, inbox_id, search_text="Booking confirmation"):
        with mailslurp_client.ApiClient(self.configuration) as api_client:
            api_instance = mailslurp_client.WaitForControllerApi(api_client)
            match_options = {'matches': [{'field': 'SUBJECT','should':'CONTAIN','value':f'{search_text}'}]}
            emails = api_instance.wait_for_matching_emails(inbox_id=inbox_id, match_options=match_options, timeout=200000, unread_only=True, count=1)
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
    
    @keyword("Extract All Links")
    def extract_all_links(self, email_body):
        soup = BeautifulSoup(email_body , "html.parser")
        links = soup.find_all('a', href=True)
        all_links = []
        if len(links) > 0:
            for l in links:
                if not 'goo.gl' in l.attrs['href']:
                    for d in self.domains:
                        if(d in l.attrs['href']):
                            all_links.append(l.attrs['href'])
        return all_links

    def find_date(self, string_content, client='omena'):
        date = '00.00.0000'
        if client == 'omena':
            pattern = r'\b\d{2}\.\d{2}\.\d{4}\b'
            match = re.search(pattern, string_content)
            if match:
                date = match.group()
        else:
            #pattern = r'<b>\d{1,2} (?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) \d{4}</b>'
            #
            date = string_content.replace('<b>', '')
            date = date.replace('</b>', '')
            date = date.replace('\n', '')
            date = date.replace('\r', '')
            date = date.lstrip().rstrip()
        return date
    
    @keyword("Extract All Links to CSV")
    def extract_all_links_to_csv(self, email_body):
        soup = BeautifulSoup(email_body , "html.parser")
        links = soup.find_all('a', href=True)
        tds = soup.find_all('td')
        booking_td = tds[3].text
        booking_td = booking_td.replace('Your booking number:\r\n', '')
        booking_td = booking_td.replace('\r', '')
        booking_td = booking_td.replace('\n', '')
        booking_id = booking_td.lstrip().rstrip()
        #zA565Yhi1#h1
        if 'Omena' in email_body:
            arrival_td = tds[14].text
            arrival_date = self.find_date(arrival_td, client='omena')
        else: # Kensington
            arrival_td = tds[15].text
            arrival_date = self.find_date(arrival_td, client='kensington')
        all_links = []
        if len(links) > 0:
            for l in links:
                if not 'goo.gl' in l.attrs['href']:
                    for d in self.domains:
                        if(d in l.attrs['href']):
                            msg_type = ''
                            if 'manage-booking' in l.attrs['href']:
                                msg_type = 'manage'
                            elif 'confirmation' in l.attrs['href']:
                                msg_type = 'confirmation'
                            elif 'receipt' in l.attrs['href']:
                                msg_type = 'receipt'
                            self.save_link_row(msg_type, booking_id, arrival_date, l.attrs['href'])
        return all_links
    
    def cleanaup_csv(self):
        data = pd.read_csv(self.temp_csv)
        cleaned_data = data.drop_duplicates()
        cleaned_data.to_csv(self.output_csv, index=False)
        print('Cleaned duplicates')


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
    
    @keyword("Mark All Emails as Read")
    def mark_all_emails_as_read(self, inbox_id=["492aa3bb-9e4b-410a-a02c-84f13ace89e8"]):
        with mailslurp_client.ApiClient(self.configuration) as api_client:
            ec = mailslurp_client.EmailControllerApi(api_client)
            mails = ec.get_emails_paginated(inbox_id=inbox_id, size=100)
            mails = mails.content
            for m in mails:
                ec.mark_as_read(m.id)
            print('All read!')

    def read_forward_inbox(self):
        with mailslurp_client.ApiClient(self.configuration) as api_client:
            ec = mailslurp_client.EmailControllerApi(api_client)
            inbox = [self.nelson_forward]
            emails = ec.get_emails_paginated(inbox_id=inbox, size=100, unread_only=unread_only).to_dict()['content']
            for e in emails if len(emails) > 0 else []:
                email = self.email_client.get_email_html(email_id=e['id'])
                try: 
                    links = self.extract_all_links_to_csv(email)
                except Exception as e:
                    print(e)
                    continue
            self.cleanaup_csv()
                
    def save_link_row(self, msg_type, booking_no, date, link):
        data = [msg_type, booking_no, date, link]
        with open(self.temp_csv, 'a', encoding='UTF8') as f:
            writer = csv.writer(f)
            writer.writerow(data)
               
if __name__ == '__main__':
    unread_only = True # True for prod
    m = MailSlurp()
    m.read_forward_inbox()

    #m.mark_all_emails_as_read()
    #i = m.get_all_inboxes()
    #inbox_id = "efc7c87b-8bcf-4ad9-bb4e-c5c459b2d526"

    #e = m.wait_for_latest_booking_confirmation()
    #e = m.get_confirmation_number_from_email(e)
    #print(e)
    #e = m.wait_for_latest_booking_confirmation('492aa3bb-9e4b-410a-a02c-84f13ace89e8', 'Welcome to Exhibition')
    #bn = m.get_confirmation_number_from_email(e)
    

