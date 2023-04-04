# frozen_string_literal: true

module GitHubApp
  module Actions
    module Comment
      # Adds a comment to the issue
      # :param package: The package containing the octokit client, payload, action, and logger
      def self.run(package)
        # destructure the package
        octokit, payload, action, _log = package.values_at(:octokit, :payload, :action, :log)

        octokit.add_comment(
          payload['repository']['full_name'],
          payload['issue']['number'],
          action[:text]
        )
      end
    end
  end
end
