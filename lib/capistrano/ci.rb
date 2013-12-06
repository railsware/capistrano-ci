require "capistrano/ci/version"
require "capistrano/ci/clients/base"
require "capistrano/ci/clients/travis"
require "capistrano/ci/clients/travis_pro"
require "capistrano/ci/clients/circle"
require "capistrano/ci/clients/semaphore"
require "capistrano/ci/client"

Capistrano::CI::Client.register "travis", Capistrano::CI::Clients::Travis, [:ci_repository]
Capistrano::CI::Client.register "travis_pro", Capistrano::CI::Clients::TravisPro, [:ci_repository, :ci_access_token]
Capistrano::CI::Client.register "circle", Capistrano::CI::Clients::Circle, [:ci_repository, :ci_access_token]
Capistrano::CI::Client.register "semaphore", Capistrano::CI::Clients::Semaphore, [:ci_repository, :ci_access_token]