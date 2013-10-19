module Capistrano
  module CI
    module Clients
      class Circle < Base
        base_uri "https://circleci.com/api/v1"

        def initialize(settings = {})
          self.class.default_params "circle-token" => settings[:ci_access_token]
          self.class.headers 'Accept' => 'application/json'

          @repository_name = settings[:ci_repository]
        end

        def passed?(branch_name)
          state(branch_name) == "success"
        end

        def state(branch_name)
          branch(branch_name)["status"]
        end

        private

        def branch(branch_name)
          @branches ||= {}
          @branches[branch_name] = find_branch(get("/project/#{@repository_name}"), branch_name)
        end

        def find_branch(response, branch_name)
          response.detect{ |item| item["branch"] == branch_name} || raise(Capistrano::CI::Clients::ResponseError)
        end
      end
    end
  end
end