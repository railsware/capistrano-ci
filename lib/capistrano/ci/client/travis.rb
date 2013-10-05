require 'travis'

module Capistrano
  module CI
    module Client
      class Travis
        attr_reader :repository_name

        def initialize(repository_name)
          @repository_name = repository_name
        end


        def passed?(branch)
          state(branch) == "passed"
        end

        def state(branch)
          repository.branch(branch).state
        end

        private

        def repository
          @repository ||= ::Travis::Repository.find(repository_name)
        end
      end
    end
  end
end
