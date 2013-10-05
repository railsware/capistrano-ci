require 'capistrano/ci'

Capistrano::Configuration.instance(true).load do
  namespace :ci do
    desc "verification of branch build status on CI"
    task :verify do
      begin
        client = Capistrano::CI::Client.new self

        unless client.passed?(branch)
          Capistrano::CLI.ui.say "Your '#{branch}' branch has '#{client.state(branch)}' state on CI."
          Capistrano::CLI.ui.ask("Continue anyway? (y/N)") == 'y' or abort
        end
      rescue => e
        Capistrano::CLI.ui.say "#{e.class.name}: #{e.message}"
      end
    end
  end
end