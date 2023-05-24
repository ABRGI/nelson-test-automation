import os
from robot.api.deco import keyword

class EnvHandler:
    @keyword("Get Environment Variable")
    def get_environment_variable(self, key):
        """Returns the value of the specified environment variable."""
        return os.environ.get(key)

    @keyword("Set Environment Variable")
    def set_environment_variable(self, key, value):
        """Sets the value of the specified environment variable."""
        os.environ[key] = value