
import random
import string
import mailslurp_client
import re
from datetime import datetime, timedelta

__version__ = '1.0.0'


class Helpers(object):
    ROBOT_LIBRARY_VERSION = __version__
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'

    def get_random_name(self, email_length=4):
        letters = string.ascii_lowercase[:12]
        return ''.join(random.choice(letters) for i in range(email_length))

    def generate_random_emails(self, length):

        domains = ["hotmail.com", "gmail.com", "aol.com",
                   "mail.com", "mail.kz", "yahoo.com"]

        return [self.get_random_name(length)
                + '@'
                + random.choice(domains)]
    
    def hello(self):
        return 'hi'
    
    def get_selectors_for_tomorrow(self):
        today = datetime.now().date()
        next_day = today + timedelta(days=1)
        day_number = next_day.day
        month_number = next_day.month
        return str(day_number), str(month_number)
    
    def get_selectors_for_far_date(self):
        today = datetime.now().date()
        next_day = today + timedelta(days=60)
        day_number = next_day.day
        month_number = next_day.month
        return str(day_number), str(month_number)
        
    def find_visible_element(self, elements):
        for i in elements:
            print(i)
        
        return elements[1]
    
    def strip_booking_number(self, text):
        booking_no = text.split(': ')[-1]
        return booking_no

    def extract_guid_from_url(self, url):
        pattern = r"[0-9a-f]{8}-([0-9a-f]{4}-){3}[0-9a-f]{12}"

        # Use regular expressions to find the GUID in the URL
        match = re.search(pattern, url)

        if match:
            guid = match.group(0)
            print(guid)
            return guid
        else:
            return None
    
    def get_environment_from_url(self, url):
        e = ''
        if 'test' in url:
            e = 'test-'
        else:
            e = 'prod-'
        if 'exhibition' in url:
            e = e+'exhibition'
        else:
            e = e+'omena'
        return e

if __name__ == '__main__':
    h = Helpers()
    he = h.get_selectors_for_tomorrow()
    
    env = h.get_environment_from_url('https://test4.omenahotels.com/en/')
    env = h.get_environment_from_url('https://test-exhibition.nelson.management/management/#/reservations')
    stripped = h.extract_guid_from_url("https://test4.omenahotels.com/en/booking/#/confirmation/1d594962-60d6-4d73-964b-806f4de38442?result=success&email=saragee@gmail.com")
    print('Stripped guid', stripped)
    email = h.generate_random_emails(10)
    print(email)
    s = h.strip_booking_number("Booking number: 123456")
    print(s)
    
    