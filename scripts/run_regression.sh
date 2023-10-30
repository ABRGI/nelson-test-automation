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
# robot -A environments/pretest.txt --outputdir reports/pretest testsuites/pretest.robot


# Iterate over the array of environments
for url in "${environments[@]}"; do
  # Send GET request and capture the response
  response=$(curl -sb -o /dev/null "$url")
  echo "Response from $url: $response"
  # Check if the response is "true"
  if [[ $response == "true" ]]; then
    echo "Running tests for environment ${url##*/}"
    echo "***"
    robot -L trace -A environments/${url##*/}.txt \
     --outputdir reports/${url##*/} \
     --xunit xunit.xml \
     testsuites/BUI/regression/create_booking_and_check_in.robot
  else
    echo $response
    echo "Environment $url is offline, not running tests."
  fi
done