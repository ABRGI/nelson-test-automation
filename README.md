# Nelson Automation Test Repository

## Environment Setup

Before running or developing test cases, it is recommended to use a virtual environment.

```virtualenv venv
source venv/bin/activate
pip install -r requirements.txt
rfbrowser init
```

Initiating the rfbrowser for the first time might take some time due to installing node dependencies. These need to be done only once, after which the venv can be activated with just the command:

```source venv/bin/activate
```

If VS Code is used, it will also prompt to use the venv automatically so this step won't be necessary later.

### Environment Variables

Environment variables, mostly secrets at this point, will be saved in .env file that must not be pushed to git at any time! To set your environment up, do following:

Rename .envREMOVE to .env

```mv .envREMOVE .env
```

Fill in missing environment variables to file or export them manually. And run setenv script.

```./setenv.sh
```

## Python Versions

Let's use Python 3.10 for this project. You can check your version using the following cmd.

```python --version
```

If you have multiple Python's installed, create a virtualenvironment like this:

```python3.10 -m venv /path/to/new/venv
source /path/to/new/venv
```

Check the version again with:

```python --version
```

## Running Tests

Before running tests, you will need to set some environment variables. That can be done by 

```robot --variable headless:<bool> testsuites/
```


## Version Control

When starting a new test case:

- Create a new branch from main from the Jira issue so we will have a seamless link to the code
- Do changes, commit often
- Push the branch to origin
- Create a merge request when ready
- Keep main clean!

Branch will be named after the Jira issue.


