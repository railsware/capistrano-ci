module Capistrano
  module CI
    module Clients
      class Travis < Base
        base_uri 'https://api.travis-ci.org'

        attr_reader :repository_name

        def initialize(settings = {})
          self.class.headers 'Accept' => 'application/json; version=2'

          @repository_name = settings[:ci_repository]
        end

        def passed?(branch)
          state(branch) == "passed"
        end

        def state(branch)
          branch(branch)["state"]
        end

        private

        def repository
          @repository ||= get("/repos/#{@repository_name}")["repo"]
        end

        def branch(branch_name)
          @branches ||= {}
          @branches[branch_name] ||= get("/repos/#{repository["id"]}/branches/#{branch_name}")["branch"]
        end
      end
    end
  end
end