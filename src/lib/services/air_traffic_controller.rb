# frozen_string_literal: true

require 'dotenv/load' # Manages environment variables
require "httparty"

# Fetches the ATC endpoint from the environment variables
ATC_ENDPOINT = ENV.fetch('ATC_ENDPOINT', nil)

module GitHubApp
  module Services
    class AirTrafficController
      def initialize(logger: nil)
        @log = logger || Logger.new($stdout, level: ENV.fetch('LOG_LEVEL', 'INFO').upcase)
      end

      def get(path)
        # get all commands for the repo from the ATC
        HTTParty.get("#{ATC_ENDPOINT}#{path}")
      end
    end
  end
end
