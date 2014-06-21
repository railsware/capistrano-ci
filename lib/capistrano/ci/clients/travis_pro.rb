module Capistrano
  module CI
    module Clients
      class TravisPro < Travis
        base_uri 'https://api.travis-ci.com'

        def initialize(settings = {})
          @repository_name = settings[:ci_repository]

          self.class.headers 'Accept' => 'application/vnd.travis-ci.2+json', "Authorization" => "token #{settings[:ci_access_token]}"
        end
      end
    end
  end
end
