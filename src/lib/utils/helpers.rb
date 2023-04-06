# frozen_string_literal: true

require "dotenv/load" # Manages environment variables

# Fetches the name of the bot from the environment variables
BOT_SELF = ENV.fetch("GITHUB_APP_NAME", nil)

module GitHubApp
  module Helpers
    # Checks if the comment was created by the bot itself
    # :param payload: The payload of the webhook
    # :return: True if the comment was created by the bot itself, False otherwise
    # Note: payload['sender']['type'] will be set to "Bot" in this context as well
    def self.from_self?(payload)
      payload["sender"]["login"] == BOT_SELF
    end

    # Checks if the requested command is in an "active" state or not
    # :param command: The command object (Hash)
    # :return: true if the command is active, false otherwise
    def self.active_command?(command)
      return command[:data][:state] == "active"
    end

    # Checks if the command issued is a registered command in the ATC
    # :param atc: The Air Traffic Controller service
    # :param payload: The payload of the webhook
    # :return: The command object (Hash), False otherwise
    def self.valid_command?(atc, payload)
      # get all commands for the repo from the ATC
      resp = atc.get("/#{payload['repository']['full_name']}/commands")

      if resp.code != 200
        raise "Error fetching commands from ATC for #{payload['repository']['full_name']}: #{resp.code}"
      end

      # convert the response to a hash
      data = JSON.parse(resp.body, symbolize_names: true)

      # loop through all returned commands and check if the comment body matches
      data.each do |command|
        return command if payload["comment"]["body"].start_with?(command[:data][:command])
      end

      # if we get here, the command is not valid
      return false
    end
  end
end
