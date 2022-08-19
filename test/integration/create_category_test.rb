require 'test_helper'

class CreateCategoryTest < ActionDispatch::IntegrationTest
  test "get new category form, submit and check redirect to category" do
    get "/categories/new"
    assert_response :success
    assert_difference("Category.count", 1) do
      post categories_path, params: { category: { name: 'Sport' } } 
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match 'Sport', response.body
  end

  test "get new category form, submit and reject submission" do
    get "/categories/new"
    assert_response :success
    assert_no_difference "Category.count" do
      post categories_path, params: { category: { name: ' ' } } 
    end
    assert_match 'errors', response.body
    assert_select 'div.alert'
  end

end
