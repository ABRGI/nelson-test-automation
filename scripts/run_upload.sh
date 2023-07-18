
export TESTMO_TOKEN=testmo_api_eyJpdiI6Im5PZjZ5WU1uZjdwRXdOVTcxQVRreVE9PSIsInZhbHVlIjoiaWptQnZPbG10bkMzT0RpVHVJSDAxRmZsV1J0cWM2dFVTU3NxUzdkZi9BST0iLCJtYkZi9BST0iLCJtYWMiOiJhMTU0Y2FmYmQ2YzA3OTgzMWEwODhiOWJjMDBlYWY5ZjhmMjA0ZGRjZTMyYmE2NjYxNjBhYzQ3ZGJlYzc5MGY0IiwidGFnIjoiIn0=
robot -A environments/test4.txt \
--include pretest \
--outputdir reports/test4 \
testsuites/


testmo automation:run:submit --instance https://softico.testmo.net --project-id 1 --name "Robot test run" --source "CI" --results reports/test4/*.xml


