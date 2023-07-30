
#robot -A environments/test4.txt \
#--outputdir reports/test4 \
#testsuites/

export TESTMO_TOKEN=testmo_api_eyJpdiI6Im9IMFN3M24zMmdWTU00d0NyZ1E5b2c9PSIsInZhbHVlIjoiT1JNUUVHNnNydDk5RHhwMU5VUEtkV0xsc1lCMlk3R1A0L3pZekcydUhwND0iLCJtYWMiOiIxNzFlNTc0NzliZDU4MTI0ZTMxMjU0N2Q5NzRiNTYxNTMzNDc1ZDZmYmJmOWNjMzRlYjAwYjczY2ZiMTUyN2Q5IiwidGFnIjoiIn0=
testmo automation:run:submit --instance https://softico.testmo.net --project-id 1 --name "Robot test run" --source "CI" --results reports/test4/*.xml


