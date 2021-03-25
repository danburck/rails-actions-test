# rails-test-pipeline [![Build Status](https://github.com/rspec/rspec-core/workflows/RSpec%20CI/badge.svg)](https://github.com/danburck/rails-test-pipeline/actions)

`rails-test-pipeline` provides a structure for setting up automated tests using RSpec and Minitest (included in Rails by default) for rails on github.

## Install
### Set up rails app with postgres
```
$ rails new my-rails-app --database=postgresql
$ cd my-rails-app
$ rails db:create

$ git add .
$ git commit -m "rails new"
$ gh repo create
$ git push origin master
```

### Configure RSpec for Unit tests
 Follow the rspec documentation to add and install the rspec gem [rspec/rspec-rails](https://github.com/rspec/rspec-rails)
 
### Configure Minitest for System tests
Install the launchy gem
In Gemfile
```
group :test do
  # [...]
  gem 'launchy'
end
```
```
$ bundle install
```

In `test/test_helper.rb` include `devise warden` (for testing applications with login functionality) and `capybara headless chrome` for imitating user behaviour without opening a browser. 
```ruby
class ActiveSupport::TestCase
  # [...]
end

Capybara.register_driver :headless_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new(args: %w[no-sandbox headless disable-gpu window-size=1400,900])
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end
Capybara.save_path = Rails.root.join('tmp/capybara')
Capybara.javascript_driver = :headless_chrome
``` 


Set up Browser tests in `test/application_system_test_case.rb`
```ruby
class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :headless_chrome # Update this line
end
```

Make Debugging easier by adding `config/environments/test.rb`
```ruby
Rails.application.configure do
  # [ ... ]
  config.action_dispatch.show_exceptions = true # Update this line
  # [ ... ]
end
```

### Set up test workflow with Github Actions
Github Actions will build a test environment and run unit/system tests on every push or pull request.

1. Add the file `.github/workflows/test.yml` in root directory and copy the script to build and run tests from [here](/.github/workflows/test.yaml)
2. Make sure you have your ruby version defined in `.ruby-version`. In this example its `2.6.6`
3. Add the file `config/database.github.yml` in root directory and copy config for the test database environment from [here](/config/database.github.yml).
4. Optional - Make passing all tests mandatory in order to merge code into master: In your repo go to `Settings/Branches` and `Add rule` and activate `Require status checks to pass before merging` as well as your `test`.


## Usage
The Github Action will automatically run unit tests with `$ bundle exec rspec` and system tests with `$ rails test:system`. Lets write some tests. 

### Unit tests
Write unit tests with RSpec to test your models.

As an example lets build the model `Tree`
```
$ rails g model Tree age:integer # automatically creates spec/models/tree_spec.rb
$ rails db:migrate
```

Lets write a simple test for creating a `Tree` instance and its `age` accessor. In `spec/models/tree_spec.rb` write

```ruby
require 'rails_helper'

describe Tree, type: :model do
  it 'creates a Tree instance with an age' do
    tree = Tree.new(age: 13)
    expect(tree.age).to eq(13)
  end
end
```
Learn more about Rspec [here](https://github.com/rspec/rspec-core).


### System tests
Use System/Integration tests to imitate the core user journey. Keep the amount of system tests low as they are very time costly. 

Lets take our `Tree` example from above and create a new system test
```
$ rails g system_test tree
```

System tests require an own environment that has a different database than local and production database. Therefore we set up a testing database called `fixtures`. We can quickly write them in yml in `test/fixtures/trees.yml`:
```yml
apple_tree:
  age: 13
pear_tree:
  age: 10
```

Write a test in `test/system/products_test.rb` to test the display of a tree's age in the trees_path
```ruby
require "application_system_test_case"

class ProductsTest < ApplicationSystemTestCase
  test "visit home page and see headline" do
    visit trees_path
    save_and_open_screenshot # only works with launchy and opens browser to take a screenshot, take in and out like raise
    assert_selector "h1", text: "13"
  end
end
```

Here is an exmaple of what the test is looking for in the `trees_path`:
```ruby 
<% @trees.each do |tree| %>
  <h1>tree.age</h1>
<% end %>
```



Learn more about Minitests [here](TODO)
