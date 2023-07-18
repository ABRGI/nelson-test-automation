

#!/bin/bash

# Define the array of environment URLs
# TBD: Add to variables somewhere
environments=(
  #"https://softico-dev-agent.frendsapp.com/api/qa/v1/status/test3"
  "https://softico-dev-agent.frendsapp.com/api/qa/v1/status/test4"
  #"https://softico-dev-agent.frendsapp.com/api/qa/v1/status/ectest"
)

# Run the pretest suite
# TBD: Add whatever needs to be done before the tests
#robot -A environments/pretest.txt --outputdir reports/pretest testsuites/pretest.robot
set TESTMO_TOKEN=$TESTMO_TOKEN
# Iterate over the array of environments
for url in "${environments[@]}"; do
  echo $url
  # Send GET request and capture the response
  response=$(curl -sb -o /dev/null "$url")

  # Check if the response is "true"
  if [[ $response == "false" ]]; then
    #robot -A environments/${url##*/}.txt --outputdir reports/${url##*/} testsuites/
    echo reports/${url##*/}/*.xml 
    export ARGFILE=environments/${url##*/}.txt
    testmo automation:run:submit \
    --instance https://softico.testmo.net \
    --project-id 1 \
    --name "Robot test run" \
    --source "CI" \
    --results reports/${url##*/}/*.xml \
    -- robot --xunit -A $ARGFILE \
    --include pretest --outputdir reports/${url##*/} testsuites/

    # Exit the loop if the command was executed
    break
  else
    echo $response
    echo "Condition not met for environment: $url. Skipping command execution."
  fi
done
