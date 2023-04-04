# frozen_string_literal: true

module GitHubApp
  module Actions
    module WorkflowDispatch
      # Dispatches a workflow run
      # :param package: The package containing the octokit client, payload, action, and logger
      def self.run(package)
        # destructure the package
        octokit, payload, action, log = package.values_at(:octokit, :payload, :action, :log)

        ref = action[:ref] || nil

        # if the ref is nil, we need to get the default branch
        if ref.nil?
          default_branch = octokit.repository(payload['repository']['full_name']).default_branch
          log.debug("ref is nil, using default branch: #{default_branch}")
        end

        # dispatch the workflow
        octokit.post(
          "/repos/#{payload['repository']['full_name']}/actions/workflows/#{action[:path]}/dispatches",
          {
            ref: default_branch # required
          }
        )
      end
    end
  end
end
