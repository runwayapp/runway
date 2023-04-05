# frozen_string_literal: true

require_relative "../utils/helpers"
require_relative "../actions/workflow_dispatch"
require_relative "../actions/reaction"
require_relative "../actions/comment"

module GitHubApp
  module Handler
    class IssueCommentCreated
      def initialize(logger: nil)
        @log = logger || Logger.new($stdout, level: ENV.fetch("LOG_LEVEL", "INFO").upcase)
      end

      # Handles issue_comment.created webhook
      # This method is also invoked for comments on pull requests
      # :param octokit: The authenticated Octokit client
      # :param atc: The Air Traffic Controller service
      # :param payload: The payload of the webhook
      def handle(octokit, atc, payload)
        # Exit if the comment was created by the bot itself to prevent infinite loops
        if GitHubApp::Helpers.from_self?(payload)
          @log.debug("ignoring comment from self - #{payload['repository']['full_name']}")
          return
        end

        # Check if the command is valid
        command = GitHubApp::Helpers.valid_command?(atc, payload)
        return if command == false

        # the package to send to all actions
        package = {
          octokit:,
          payload:,
          action: nil,
          log: @log
        }

        # A 'command' will have one or more 'actions' to perform
        actions = command[:data][:actions]
        actions.each do |action|
          # set the action in the package
          package = package.merge({ action: })

          case action[:type]
          when "workflow_dispatch"
            GitHubApp::Actions::WorkflowDispatch.run(package)
          when "reaction"
            GitHubApp::Actions::Reaction.run(package)
          when "comment"
            GitHubApp::Actions::Comment.run(package)
          end
        end
      end
    end
  end
end
