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

Create a file .env in the root directory and use setenv.sh script or source .env in CLI. Verify variables are accessible.

If you are using RobotCode Debugger features in VS Code, environment variables need to be set from the extension settings.

## Python Versions

Let's use Python 3.10 for this project. You can check your version using the following cmd. Python 3.11 seems to be working as well.

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

## Folder Structure

[testsuites](/testsuites/) is the main folder for all test suite files ie. anything ending .robot.

[resources](/resources/) is the main folder for libraries, variables, python files, other files, anything that is used in the test cases. For now, resources are divided into [keywords](/resources/keywords/), [libraries](/resources/libraries/) and [variables](/resources/variables/).

[environments](/environments/) contains startup arguments for each environment. 


Test Suites are divided into [MUI](/testsuites/MUI/), [BUI](/testsuites/BUI/) and [API](/testsuites/API/) and new test cases should be added accordingly. Each folder also contains subfolders for features and regression tests.

All of the above are divided into features and regression tests. Feature tests can be named for example with the Jira Ticket number and ordered to subfolders like [OnlineCheckIn](/testsuites/MUI/feature/online_check_in/). This will be up to you in later phases to see what works best.

## Test Suite and Test Case Naming

Test suites should be named in a brief, yet explanatory manner and they should be consistent within the naming and casing. In Robot Framework, generally snake_case is used for everything, but I would keepi Jira tickets as they are (BUI-556.robot instead of snake case like bui_556.robot).

## Variables

It is generally desirable to use variables instead of strings in Test Cases which should be kept clear from any "code like" syntax. This can be prevented by using keywords and variables.

Regarding casing, I have now started to use camelCase for general variables and UPPERCASE for environment variables and secrets. There is no right or wrong here, just what is preferred. However, I suggest it is kept consistent as well.

## Running Tests

Before running tests, you will need to set some environment variables. That can be done by running tests with.

``` bash
robot -A environments/env_name.txt testsuites/
```

When running tests in CI, we will start using pabot to execute tests in paralle at some point. Arguments for each environment have been set in environment files in environments folder. Currently tests are run separately.

```bash
pabot -A environments/test4.txt -A environments/test3.txt testsuites/ 
```

### Branches and environments

We are using develop branch for running against staging environment(s) and master for running against production environment.

### Tags

Currently we exclude tests that are tagged with skip. Include tags that make sense in your opinion to your test cases. There are no strict rules for these at this point.

## Debugging

I suggest using [RoboCode VS Code Extension](https://github.com/d-biehl/robotcode) for debugging and if there is a need to run tests locally. Set up variables in extension settings.

## Version Control

When starting a new test case:

- Create a new branch from develop using naming convention feature/<Jira ticket id> <Description>
- Do changes, commit often
- Push the branch to origin
- Create a merge request when ready
- Keep master clean!

Branch will be named after the Jira issue.

## GitHub Actions / Testing CI

Initial CI has been done in [/.github/workflows/run-tests.yml], which will run the tests on push to develop and upload results to GitHub pages with the default RobotFramework report.

Run command is currently as follows but also subject to change:

```bash
robot -A environments/env_name.txt --outputdir reports/pretest testsuites/
```

GitHub pages are deployed from [gh-pages branch](https://github.com/ABRGI/nelson-test-automation/tree/gh-pages) and are visible at: 
[https://abrgi.github.io/nelson-test-automation/report.html](https://abrgi.github.io/nelson-test-automation).

## Reporting and Jenkins CI

### GitHub Pages
GitHub pages are deployed from [gh-pages branch](https://github.com/ABRGI/nelson-test-automation/tree/gh-pages) and are visible at: 
[https://abrgi.github.io/nelson-test-automation/report.html](https://abrgi.github.io/nelson-test-automation).

This is done in the latter part of the yml file, where the runner will commit all result files from the current branch into the gh-pages branch. Pages will then update immediately. 

See GitHub Pages and GitHub Actions documentation for more.

### Jenkins CI and Reports

Also see the sandbox Jenkins: [http://nelsonqa.northeurope.cloudapp.azure.com:8080/](http://nelsonqa.northeurope.cloudapp.azure.com:8080/) Credentials given in chat. 


## API Tests

API Tests will be integrated into this repository when there is time allocated for the task.
