require "test_helper"

class OriginalStringTest < ActiveSupport::TestCase
  test "should not save original string without a value" do
    original_string = OriginalString.new
    assert_not original_string.save, "Saved the original string without a value"
  end

  test "should not save original string with value exceeding 1000 characters" do
    original_string = OriginalString.new(value: "a" * 1001)
    assert_not original_string.save, "Saved the original string with a value exceeding 1000 characters"
  end

  test "should save original string with valid value" do
    original_string = OriginalString.new(value: "a" * 500)
    assert original_string.save, "Could not save the original string with a valid value"
  end
end
