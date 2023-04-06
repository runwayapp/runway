FROM ruby:3.2.1-slim

# set the working directory
WORKDIR /app

# install necessary packages
RUN apt-get update && apt-get install -y \
  build-essential \
  bash

# copy the project and exclude the files in .dockerignore
COPY . .

# create a nonroot user
RUN groupadd -r nonroot && useradd -r -g nonroot nonroot

# bootstrap the project
RUN RACK_ENV=production script/bootstrap

# create the log and tmp directories
RUN mkdir -p /app/log /app/tmp/pids /app/logs

# set the permissions for the app directory and the nonroot user
RUN chown nonroot:nonroot /app

# switch to the nonroot user
USER nonroot

EXPOSE 8080
CMD [ "./script/server" ]
