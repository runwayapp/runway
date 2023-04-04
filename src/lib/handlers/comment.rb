# frozen_string_literal: true

require_relative "../utils/helpers"

module GitHubApp
  module Handler
    class IssueCommentCreated
      def initialize(logger: nil)
        @log = logger || Logger.new($stdout, level: ENV.fetch('LOG_LEVEL', 'INFO').upcase)
      end

      # Handles issue_comment.created webhook
      # This method is also invoked for comments on pull requests
      # :param octokit: The authenticated Octokit client
      # :param payload: The payload of the webhook
      def handle(octokit, payload)
        # Exit if the comment was created by the bot itself to prevent infinite loops
        if GitHubApp::Helpers.from_self?(payload)
          @log.debug("ignoring comment from self - #{payload['repository']['full_name']}")
          return
        end

        # Check if the command is valid
        command = GitHubApp::Helpers.valid_command?(payload)
        return if command == false

        octokit.add_comment(
          payload['repository']['full_name'],
          payload['issue']['number'],
          "command received: #{command} is valid"
        )

        # issue_number = payload['issue']['number']
        # octokit.post(
        #   "/repos/#{repo}/actions/workflows/test.yml/dispatches",
        #   {
        #     ref: "main"
        #   }
        # )
      end
    end
  end
end
