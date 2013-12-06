module Capistrano
  module CI
    module Clients
      class Semaphore < Base
        base_uri 'https://semaphoreapp.com/'

        attr_reader :repository_name

        def initialize(settings = {})
          self.class.default_params "auth_token" => settings[:ci_access_token]

          @repository_name = settings[:ci_repository]
        end

        def passed?(branch_name)
          state(branch_name) == "passed"
        end

        def state(branch_name)
          branch(branch_name)["result"]
        end

        private

        def branch(branch_name)
          project["branches"].detect { |branch| branch["branch_name"] == branch_name } || raise(ResponseError)
        end

        def project
          owner, name = repository_name_parts
          projects.detect { |project| project["owner"] = owner && project["name"] == name } || raise(ResponseError)
        end

        def repository_name_parts
          self.repository_name.split("/")
        end

        def projects
          get("/api/v1/projects")
        end
      end
    end
  end
end