require 'travis/pro'

module Capistrano
  module CI
    module Clients
      class TravisPro < Travis
        def initialize(repository_name, api_token)
          @repository_name = repository_name
          ::Travis::Pro.access_token = api_token
        end

        private

        def repository
          @repository ||= ::Travis::Pro::Repository.find(repository_name)
        end
      end
    end
  end
end
