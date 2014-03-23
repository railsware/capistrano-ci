require 'capistrano/version'
require 'capistrano/ci'

if defined?(Capistrano::VERSION) && Gem::Version.new(Capistrano::VERSION).release >= Gem::Version.new('3.0.0')
  load 'capistrano/ci/recipes/v3.rake'
else
  load 'capistrano/ci/recipes/v2.rb'
end
