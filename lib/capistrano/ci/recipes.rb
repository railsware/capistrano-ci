require 'travis/pro'

namespace :ci do
  desc "verification of branch build status on Travis CI"
  task :verify do
    begin
      Travis::Pro.access_token = ci_access_token
      repo = Travis::Pro::Repository.find(ci_repository)
      branch_state = repo.branch(branch).state

      unless branch_state == "passed"
        Capistrano::CLI.ui.say "Your '#{branch}' branch has '#{branch_state}' state on CI."
        Capistrano::CLI.ui.ask("Continue anyway? (y/N)") == 'y' or abort
      end
    rescue => e
      Capistrano::CLI.ui.say e.message
    end
  end
end