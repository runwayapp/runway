FROM ruby:3.2.1-alpine

COPY .ruby-version .ruby-version

WORKDIR /app

# create nonroot user
RUN useradd -m nonroot

RUN chown nonroot:nonroot /app

# switch to the nonroot user
USER nonroot
