# rails-test-pipeline [![Build Status](https://github.com/rspec/rspec-core/workflows/RSpec%20CI/badge.svg)](https://github.com/danburck/rails-test-pipeline/actions)

`rails-test-pipeline` provides a structure for setting up automated tests using RSpec and Minitest for rails on github.

## Install
### Set up rails app with postgres
```
$ rails new my-rails-app --database=postgresql
$ cd my-rails-app

$ git add .
$ git commit -m "rails new"
$ gh repo create
$ git push origin master
```

### Install RSpec
 Follow the rspec documentation to add and install the rspec gem [rspec/rspec-rails](https://github.com/rspec/rspec-rails)

### Set up test workflow with Github Actions
Github Actions will build a test environment and run unit/system tests on every push or pull request.

1. Add the file `.github/workflows/test.yml` in root directory and copy the script to build and run tests from [here](/.github/workflows/test.yaml)
2. Add the file `config/database.github.yml` in root directory and copy config for the test database environment from [here](/config/database.github.yml).
3. Optional - Make passing all tests mandatory in order to merge code into master: In your repo go to `Settings/Branches` and `Add rule` and activate `Require status checks to pass before merging` as well as your `test`.


## Usage
TODO

### Unit tests
TODO

### System tests
TODO
