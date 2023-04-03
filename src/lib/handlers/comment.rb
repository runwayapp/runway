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
        return if GitHubApp::Helpers.from_self?(payload)

        octokit.add_comment(
          payload['repository']['full_name'],
          payload['issue']['number'],
          'test flight'
        )
      end
    end
  end
end
