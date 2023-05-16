
# TBD: Not yet in use
FROM node:16-bullseye

# Set environment variables
ENV ROBOT_REPORTS_DIR /opt/sqa/results
ENV ROBOT_TESTS_DIR /opt/sqa/testsuites
ENV ROBOT_WORK_DIR /opt/sqa
ENV SCREEN_COLOUR_DEPTH 24
ENV SCREEN_HEIGHT 1080
ENV SCREEN_WIDTH 1920
ENV TZ GMT+2
ENV ROBOT_THREADS 1
ENV ROBOT_UID 1000
ENV ROBOT_GID 1000

## Copy required files
COPY requirements.txt /opt/sqa/requirements.txt
COPY resources/     /opt/sqa/resources
COPY scripts/       /opt/sqa/scripts
COPY testsuites/       /opt/sqa/testsuites
COPY ./setenv.sh       /opt/sqa/setenv.sh
COPY ./credentials.json     /opt/sqa/credentials.json
RUN  chmod +x   /opt/sqa/setenv.sh
# Install dependencies
RUN apt update
RUN apt-get install -y python3-pip && ln -sf python3 /usr/bin/python
RUN pip3 install --upgrade pip setuptools
RUN apt install -y bash curl sudo
RUN pip install -r /opt/sqa/requirements.txt
RUN rfbrowser init
RUN yes | npx -y playwright install-deps     
RUN /opt/sqa/setenv.sh

RUN chmod -R +x    /opt/sqa/

WORKDIR ${ROBOT_WORK_DIR}
