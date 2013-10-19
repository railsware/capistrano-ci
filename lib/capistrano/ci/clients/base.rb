require "httparty"

module Capistrano
  module CI
    module Clients
      class ResponseError < StandardError; end

      class Base
        include HTTParty

        def passed?(branch)
          raise NotImplementedError
        end

        def state(branch)
          raise NotImplementedError
        end

        private

        def get(url)
          response = self.class.get(url)

          if response.response.code == "200"
            response.parsed_response
          else
            raise Capistrano::CI::Clients::ResponseError
          end
        end

      end
    end
  end
end
