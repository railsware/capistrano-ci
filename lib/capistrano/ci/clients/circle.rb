module Capistrano
  module CI
    module Clients
      class Circle < Base
        base_uri "https://circleci.com/api/v1"

        def initialize(repository_name, api_token)
          self.class.default_params "circle-token" => api_token
          self.class.headers 'Accept' => 'application/json'

          @repository_name = repository_name
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