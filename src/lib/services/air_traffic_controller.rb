# frozen_string_literal: true

require 'dotenv/load' # Manages environment variables
require "httparty"

module GitHubApp
  module Services
    class AirTrafficController
      def initialize(logger: nil)
        @log = logger || Logger.new($stdout, level: ENV.fetch('LOG_LEVEL', 'INFO').upcase)
        @endpoint = ENV.fetch('ATC_ENDPOINT', nil)
      end

      def refresh
        true
      end

      def get(path)
        # get all commands for the repo from the ATC
        HTTParty.get("#{@endpoint}#{path}")
      end
    end
  end
end
