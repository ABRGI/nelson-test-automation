#!/bin/bash



# Define the array of environment URLs
# TBD: Add to variables somewhere
environments=(
  "https://softico-dev-agent.frendsapp.com/api/qa/v1/status/test3"
  "https://softico-dev-agent.frendsapp.com/api/qa/v1/status/test4"
  "https://softico-dev-agent.frendsapp.com/api/qa/v1/status/ectest"
)

# Run the pretest suite
# TBD: Add whatever needs to be done before the tests
robot -A environments/pretest.txt --outputdir reports/pretest testsuites/pretest.robot

# Iterate over the array of environments
for url in "${environments[@]}"; do
  # Send GET request and capture the response
  response=$(curl -sb -o /dev/null "$url")

  # Check if the response is "true"
  if [[ $response == "false" ]]; then
    echo "Running tests for ${url##*/}"
    robot -L trace -A environments/${url##*/}.txt --outputdir reports/${url##*/} --xunit xunit.xml testsuites/
    # Exit the loop if the command was executed
    break
  else
    echo $response
    echo "Condition not met for environment: $url. Skipping command execution."
  fi
done