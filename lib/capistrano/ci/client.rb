module Capistrano
  module CI
    class Client
      class NotFound < StandardError; end

      class << self
        def register(client_name, client_class, attributes = [])
          self.clients[client_name] ||= { client_class: client_class, attributes: attributes }
          @settings = settings | attributes
        end

        def clients
          @clients ||= {}
        end

        def settings
          @settings ||= [:ci_client]
        end
      end


      def initialize(config)
        @config = self.class.settings.inject({}) do |result, key|
          result[key] = config[key] if config.exists?(key)
          result
        end
      end

      def state(branch)
        client.state(branch)
      end

      def passed?(branch)
        client.passed?(branch)
      end

      private

      def client
        @client ||= find_and_initialize_client or raise(NotFound, "can't find CI client with name '#{@config[:ci_client]}'")
      end

      def find_and_initialize_client
        client_settings = self.class.clients[@config[:ci_client]]

        client_settings[:client_class].new(prepare_client_attributes(client_settings)) if client_settings
      end

      def prepare_client_attributes(settings)
        @config.select{ |key, _| settings[:attributes].include?(key) }
      end

    end
  end
end
