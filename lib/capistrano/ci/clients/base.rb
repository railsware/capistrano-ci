module Capistrano
  module CI
    module Clients
      class Base
        def passed?(branch)
          raise NotImplementedError
        end

        def state(branch)
          raise NotImplementedError
        end

      end
    end
  end
end
