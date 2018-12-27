#Grab the latest alpine image
FROM alpine:latest

# Install python and pip
RUN apk add --no-cache --update \
  python3 \
  python3-dev \
  py3-pip \
  bash \
  gcc \
  postgresql-dev \
  musl-dev
RUN pip3 install --no-cache-dir -q pipenv

# Add our code
ADD ./ /opt/webapp/
WORKDIR /opt/webapp

# Install dependencies
RUN pipenv install --deploy --system

# Expose is NOT supported by Heroku
# EXPOSE 5000

# Run the image as a non-root user
RUN adduser -D myuser
USER myuser

# Run the app.  CMD is required to run on Heroku
# $PORT is set by Heroku
CMD waitress-serve --port=$PORT dancrowdboticscom_dan_51.wsgi:application
