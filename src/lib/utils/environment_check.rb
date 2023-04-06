# frozen_string_literal: true

module GitHubApp
  module Utils
    module EnvironmentCheck
      def self.run(log)
        log.warn("ENV is not set") if ENV.fetch("ENV", nil).nil?
        log.warn("RACK_ENV is not set") if ENV.fetch("RACK_ENV", nil).nil?
        log.warn("GITHUB_PRIVATE_KEY is not set") if ENV.fetch("GITHUB_PRIVATE_KEY", nil).nil?
        log.warn("GITHUB_WEBHOOK_SECRET is not set") if ENV.fetch("GITHUB_WEBHOOK_SECRET", nil).nil?
        log.warn("GITHUB_APP_IDENTIFIER is not set") if ENV.fetch("GITHUB_APP_IDENTIFIER", nil).nil?
        log.warn("GITHUB_APP_NAME is not set") if ENV.fetch("GITHUB_APP_NAME", nil).nil?
        log.warn("GITHUB_APP_API_KEY is not set") if ENV.fetch("GITHUB_APP_API_KEY", nil).nil?
        log.warn("ATC_ENDPOINT is not set") if ENV.fetch("ATC_ENDPOINT", nil).nil?
      end
    end
  end
end
