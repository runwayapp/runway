FROM ruby:3.2.1-slim

# set the working directory
WORKDIR /app

# install necessary packages
RUN apt-get update && apt-get install -y \
  build-essential \
  bash

# copy the project and exclude the files in .dockerignore
COPY . .

# bootstrap the project
RUN RACK_ENV=production script/bootstrap

# create the log and tmp directories
RUN mkdir -p /app/log /app/tmp/pids /app/logs

EXPOSE 80
CMD [ "./script/server" ]
