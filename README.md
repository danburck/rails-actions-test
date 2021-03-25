# setup-rails-test-pipeline

setup-rails-test-pipeline provides a structure for setting up a test pipeline for rails on github.

## Specs
* Rails
* Uses RSpec
* Ruby Version


## Install
### Set up rails app with postgres
  $ rails new my-rails-app --database=postgresql
  $ cd my-rails-app

  $ git add .
  $ git commit -m "rails new"
  $ gh repo create
  $ git push origin master


### Install RSpec
  [rspec/rspec-rails](https://github.com/rspec/rspec-rails)

### Set up test workflow with Github Actions
Github Actions will build a test environment and run unit/system tests on every push or pull request.

1. Add the file `.github/workflows/test.yml` in root directory and copy the script to build and run tests from here: https://github.com/danburck/rails-actions-test/blob/master/.github/workflows/test.yaml
2. Add the file `config/database.github.yml` in root directory and copy config for the test database environment from here:
3. Optional - Make successful tests mandatory to merge code into master: In your repo go to `Settings/Branches` and `Add rule` and activate `Require status checks to pass before merging` as well as your `test`.


### Write Tests

#### Unit tests

#### System tests








Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
