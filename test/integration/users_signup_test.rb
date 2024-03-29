require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = "Czardas Hotels - Official Website"
  end


  test "should get signup" do
    get new_user_path
    assert_response :success
    assert_select "title", "Sign up | #{@base_title}"
  end

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { first_name: "",
                                         last_name: "",
                                         country: "",
                                         mobile: "",
                                         email: "user@invalid",
                                         password: "foo",
                                         password_confirmation: "bar" } }
    end
    assert_response :unprocessable_entity
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test "valid signup information" do
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { first_name: "John",
                                         last_name: "Doe",
                                         country: "Canada",
                                         mobile: "+12341234567890",
                                         email: "johndoe@email.com",
                                         password: "foobar",
                                         password_confirmation: "foobar" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.nil?
    assert_not flash.empty?
    assert_select 'div.alert-success'
    assert is_logged_in?
  end
end
