# Nelson Automation Test Repository

## Environment Setup

Before running or developing test cases, it is recommended to use a virtual environment.

``` bash
virtualenv venv
source venv/bin/activate
pip install -r requirements.txt
rfbrowser init
```

Initiating the rfbrowser for the first time might take some time due to installing node dependencies. These need to be done only once, after which the venv can be activated with just the command:

``` bash
source venv/bin/activate
```

If VS Code is used, it will also prompt to use the venv automatically so this step won't be necessary later.

### Environment Variables

Environment variables, mostly secrets at this point, will be saved in .env file that must not be pushed to git at any time! To set your environment up, do following:

Rename .envREMOVE to .env

``` bash
mv .envREMOVE .env
```

Fill in missing environment variables to file or export them manually. And run setenv script.

``` bash
./setenv.sh
```

Environment variables can be used with the library [Operating System](https://robotframework.org/robotframework/latest/libraries/OperatingSystem.html#Get%20Environment%20Variable). Or with the from [EnvHandler.py](resources/libraries/EnvHandler.py) with keyword EnvHandler.Get Environment Variable.

``` robot
    ${username}=    EnvHandler.Get Environment Variable    MY_USERNAME
    Type Secret     id=loginUsername    ${username}
```

See [example.robot](/testsuites/example.robot)
## Python Versions

Let's use Python 3.10 for this project. You can check your version using the following cmd.

```python --version
```

If you have multiple Python's installed, create a virtualenvironment like this:

``` bash
python3.10 -m venv /path/to/new/venv
source /path/to/new/venv
```

Check the version again with:

``` bash
python --version
```

## Running Tests

Before running tests, you will need to set some environment variables. That can be done by running tests with.

``` bash
robot --variable browser:chromium --variable headless:False --variable url:https://test4.omenahotels.com/ testsuites/
```

### Branches and environments

We are using develop branch for running against staging environment(s) and master for running against production environment.

### Tags

Currently we exclude tests that are tagged with skip.

## Debugging

I suggest using [RoboCode VS Code Extension](https://github.com/d-biehl/robotcode) for debugging. Set up variables in extension settings.

- headless - true, false
- browser - chromium, firefox

## Version Control

When starting a new test case:

- Create a new branch from develop using naming convention feature/<Jira ticket id> <Description>
- Do changes, commit often
- Push the branch to origin
- Create a merge request when ready
- Keep master clean!

Branch will be named after the Jira issue.

## CI and reporting

Initial CI has been done in python-app.yaml, which will run the tests on push to develop and upload results to GitHub pages with the default RobotFramework report.

Run command is currently as follows but also sbuject to change:

```bash
robot --variable browser:chromium --variable headless:True --variable url:https://test4.omenahotels.com/ --variable MUI-Link:https://admin.nelson.management/#/login --outputdir reports/ testsuites/
```

GitHub pages are deployed from [gh-pages branch](https://github.com/ABRGI/nelson-test-automation/tree/gh-pages) and are visible at: 
[https://abrgi.github.io/nelson-test-automation/report.html](https://abrgi.github.io/nelson-test-automation).

## API Tests

API Tests will be integrated into this repository after we have established the authentication required.