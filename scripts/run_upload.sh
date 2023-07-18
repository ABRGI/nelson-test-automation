
robot -A environments/test4.txt \
--include pretest \
--outputdir reports/test4 \
testsuites/


testmo automation:run:submit --instance https://softico.testmo.net --project-id 1 --name "Robot test run" --source "CI" --results reports/test4/*.xml


