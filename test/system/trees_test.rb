require "application_system_test_case"

class TreesTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit trees_path
    assert_selector "h1", text: "13"
  end
end
