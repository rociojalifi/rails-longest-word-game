require 'test_helper'

class LongestControllerTest < ActionDispatch::IntegrationTest
  test "should get word" do
    get longest_word_url
    assert_response :success
  end

end
