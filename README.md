
# Capistrano::Ci
[![Build Status](https://travis-ci.org/railsware/capistrano-ci.png)](https://travis-ci.org/railsware/capistrano-ci)


## Introduction

capistrano-ci is extension for capistrano that allows you to check status of your repository before deployment. Currently it supports:

  * travis-ci: Open Source and Pro versions ([https://travis-ci.org](https://travis-ci.org) or [https://travis-ci.com](https://travis-ci.com))

## Installation

Add this line to your application's Gemfile:

    gem 'capistrano-ci'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-ci

Add to your Capfile:
    $ require 'capistrano/ci/recipies'

## Configuration

Variables list: 

  * :ci_client (required) - supports 'travis' or 'travis_pro';
  * :ci_repository (required) - organization or user name and repository name on github;
  * :ci_access_token(required only for 'travis_pro' ci client) - access token for Pro account on Travis-CI.

### Open Source Projects

Setup ci_client and ci_repository variables in your deployment script: 

     set(:ci_client){ "travis" }
     set(:ci_repository){ "organisation-or-user/repository-name" }

### Pro Account of Travis-CI:

Additional to ci_client and ci_repository setup ci_access_token: 

     set(:ci_client){ "travis_pro" }
     set(:ci_repository){ "organisation-or-user/repository-name" }
     set(:ci_access_token){ "your-pro-access-token" }

To have more information about Travis-CI access token follow [this blog post](http://about.travis-ci.org/blog/2013-01-28-token-token-token)

### Enable ci:verify task:

     before 'deploy' do
       ci.verify
     end

     # or in case of using capistrano-patch: 
     before 'patch:create' do
       ci.verify
     end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright

Copyright (c) 2013 Railsware LLC. See LICENSE.txt for
further details.