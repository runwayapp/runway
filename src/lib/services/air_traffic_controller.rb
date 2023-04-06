# frozen_string_literal: true

require "httparty"
require "jwt"

module GitHubApp
  module Services
    class AirTrafficController
      def initialize(logger: nil)
        @log = logger || Logger.new($stdout, level: ENV.fetch("LOG_LEVEL", "INFO").upcase)
        @endpoint = "#{ENV.fetch("ATC_ENDPOINT", nil)}/api/v1"
        @jwt_token = nil
        @jwt_token_raw = nil
        @api_key_headers = {
          "x-api-key": ENV.fetch("GITHUB_APP_API_KEY", nil)
        }
        @refresh_payload = {
          login: ENV.fetch("GITHUB_APP_NAME", nil)
        }.to_json
      end

      def refresh
        # skip if we still have a valid JWT token
        if !@jwt_token.nil? && @jwt_token[0]["authorized"] == true && (Time.now.to_i < @jwt_token[0]["exp"])
          @log.debug("JWT token for the ATC is still valid, skipping refresh")
          return
        end

        @log.debug("refreshing JWT token for the ATC")

        # make an API call to get a fresh JWT token
        resp = HTTParty.post("#{@endpoint}/auth", headers: @api_key_headers, body: @refresh_payload)

        # check if the response was successful
        if resp.code != 200
          @log.error("Error fetching JWT token from ATC: #{resp.code}")
          return
        end

        # parse the response as JSON
        data = JSON.parse(resp.body, symbolize_names: true)

        # save the JWT token in the instance variables
        @jwt_token = JWT.decode(data[:token], nil, false)
        @jwt_token_raw = data[:token]
        @log.debug("JWT token for the ATC refreshed")

        @log.debug(@jwt_token[0])
      end

      def headers
        {
          Authorization: "Bearer #{@jwt_token_raw}"
        }
      end

      def get(path)
        # get all commands for the repo from the ATC
        HTTParty.get("#{@endpoint}#{path}", headers:)
      end
    end
  end
end
