module Capistrano
  module CI
    class Client
      SETTINGS = [:ci_client, :ci_repository, :ci_token]

      class NotFound < StandardError; end

      def initialize(config)
        @config = SETTINGS.inject({}) do |result, key|
          result[key] = config[key] if config.exists?(key)
          result
        end
      end

      def state(branch)
        client.state(branch)
      end

      def passed?(branch)
        client.state(branch)
      end

      private

      def client
        case @config[:ci_client]
        when "travis"
          Capistrano::CI::Clients::Travis.new @config[:ci_repository]
        else
          raise NotFound, "can't find CI client with name '#{@config[:ci_client]}'"
        end
      end
    end
  end
end
