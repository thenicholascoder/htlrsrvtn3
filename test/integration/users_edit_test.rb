require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:mark)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { first_name:  "",
                                              last_name: "",
                                              country: "",
                                              email: "foo@invalid",
                                              mobile: "",
                                              is_admin: false,
                                              password:              "foo",
                                              password_confirmation: "bar" } }
    assert_template 'users/edit'
  end

  test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'

    first_name_example = "Josh"
    last_name_example = "Sykes"
    country_example = "Canada"
    email_example = "joshsykes@email.com"
    mobile_example = "+1234567890"
    is_admin_example = false
    password_example = "12345678"
    password_confirmation_example = "12345678"

    patch user_path(@user), params: { user: { first_name:  first_name_example,
                                              last_name: last_name_example,
                                              country: country_example,
                                              email: email_example,
                                              mobile: mobile_example,
                                              is_admin: is_admin_example,
                                              password: password_example,
                                              password_confirmation: password_confirmation_example } }

    assert_not flash.empty?
    assert_redirected_to @user.reload

    # Ensure password is not nil
    assert_not_nil @user.password_digest

    # Check other attributes
    assert_equal first_name_example,  @user.first_name
    assert_equal last_name_example,   @user.last_name
    assert_equal country_example,     @user.country
    assert_equal email_example,       @user.email
    assert_equal mobile_example,      @user.mobile
    assert_equal is_admin_example,    @user.is_admin?
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    first_name_example  = "Foo"
    last_name_example  = "Bar"
    email_example = "foo@bar.com"
    patch user_path(@user), params: { user: { first_name:  first_name_example,
                                              last_name: last_name_example,
                                              email: email_example,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal first_name_example,  @user.first_name
    assert_equal last_name_example,   @user.last_name
    assert_equal email_example,       @user.email
  end
end
