namespace :ci do
  desc "verification of branch build status on CI"
  task :verify do
    begin
      client = Capistrano::CI::Client.new self

      branch = fetch(:branch)
      unless client.passed?(branch)
        puts "Your '#{branch}' branch has '#{client.state(branch)}' state on CI."
        puts "Continue anyway? (y/N)"

        abort if $stdin.gets.chomp != 'y'
      end
    rescue => e
      puts "#{e.class.name}: #{e.message}"
    end
  end
end
