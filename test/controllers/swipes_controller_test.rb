require 'test_helper'

class SwipesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get swipes_index_url
    assert_response :success
  end

end
