# frozen_string_literal: true

require 'dotenv/load' # Manages environment variables

# Fetches the name of the bot from the environment variables
BOT_SELF = ENV.fetch('GITHUB_APP_NAME', nil)

module GitHubApp
  module Helpers
    # Checks if the comment was created by the bot itself
    # :param payload: The payload of the webhook
    # :return: True if the comment was created by the bot itself, False otherwise
    # Note: payload['sender']['type'] will be set to "Bot" in this context as well
    def self.from_self?(payload)
      payload['sender']['login'] == BOT_SELF
    end
  end
end
