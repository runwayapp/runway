# frozen_string_literal: true

module GitHubApp
  module Actions
    module Reaction
      # Does reaction operations on the invoking command
      # :param package: The package containing the octokit client, payload, action, and logger
      def self.run(package)
        # destructure the package
        octokit, payload, action, _log = package.values_at(:octokit, :payload, :action, :log)

        case action[:mode]
        when "add"
          octokit.create_issue_comment_reaction(
            payload['repository']['full_name'],
            payload['comment']['id'],
            action[:reaction]
          )
        end
        # TODO: add support for removing reactions
      end
    end
  end
end
