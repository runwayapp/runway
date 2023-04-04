# frozen_string_literal: true

require_relative "../utils/helpers"

module GitHubApp
  module Handler
    class IssueCommentCreated
      def initialize(logger: nil)
        @log = logger || Logger.new($stdout, level: ENV.fetch('LOG_LEVEL', 'INFO').upcase)
      end

      # Dispatches a workflow run
      # :param octokit: The authenticated Octokit client
      # :param payload: The payload of the webhook
      # :param action: The action to perform (Hash) with data for the workflow_dispatch event
      def workflow_dispatch(octokit, payload, action)
        ref = action[:ref] || nil

        # if the ref is nil, we need to get the default branch
        if ref.nil?
          default_branch = octokit.repository(payload['repository']['full_name']).default_branch
          @log.debug("ref is nil, using default branch: #{default_branch}")
        end

        # dispatch the workflow
        octokit.post(
          "/repos/#{payload['repository']['full_name']}/actions/workflows/#{action[:path]}/dispatches",
          {
            ref: default_branch # required
          }
        )
      end

      # Adds a comment to the issue
      # :param octokit: The authenticated Octokit client
      # :param payload: The payload of the webhook
      # :param action: The action to perform (Hash) with data for the comment
      def add_comment(octokit, payload, action)
        octokit.add_comment(
          payload['repository']['full_name'],
          payload['issue']['number'],
          action[:text]
        )
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

        # A 'command' will have one or more 'actions' to perform
        actions = command[:data][:actions]
        actions.each do |action|
          case action[:type]
          when "workflow_dispatch"
            workflow_dispatch(octokit, payload, action)
          when "comment"
            add_comment(octokit, payload, action)
          end
        end
      end
    end
  end
end
