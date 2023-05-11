
import random
import string

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
    
    def find_visible_element(self, elements):
        for i in elements:
            print(i)
        
        return elements[1]
        
    
if __name__ == '__main__':
    h = Helpers()
    email = h.generate_random_emails(10)
    print(email)
    
    