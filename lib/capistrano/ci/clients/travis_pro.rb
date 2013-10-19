module Capistrano
  module CI
    module Clients
      class TravisPro < Travis
        base_uri 'https://api.travis-ci.com'

        def initialize(repository_name, api_token)
          @repository_name = repository_name

          self.class.headers 'Accept' => 'application/json; version=2', "Authorization" => "token #{api_token}"
        end
      end
    end
  end
end
