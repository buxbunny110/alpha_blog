require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = Category.create(name: 'Sport')
    @admin = User.create(username: 'johndoe', 
                         email: 'johndoe@email.com',
                         password: 'password', 
                         admin: true
                      )
  end

  test "should get index" do
    get categories_url
    assert_response :success
  end

  test "only admin should get new form" do
    sign_in_as(@admin)
    get new_category_url
    assert_response :success
  end

  test "only admin can create category" do
    sign_in_as(@admin)
    assert_difference('Category.count', 1) do
      post categories_url, params: { category: { name: 'Travel' } }
    end
  end

  test "should show category" do
    get category_url(@category)
    assert_response :success
  end

  # test "should get edit" do
  #   get edit_category_url(@category)
  #   assert_response :success
  # end

  # test "should update category" do
  #   patch category_url(@category), params: { category: {  } }
  #   assert_redirected_to category_url(@category)
  # end

  # test "should destroy category" do
  #   assert_difference('Category.count', -1) do
  #     delete category_url(@category)
  #   end

  #   assert_redirected_to categories_url
  # end
end
