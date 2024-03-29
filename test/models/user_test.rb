require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    # predefined sample / fixtures/users.yml
    # @user = users(:one)

    # to be defined sample
    @user = User.new(
      first_name: 'John',
      last_name: 'Smith',
      country: 'Canada',
      email: 'johnsmith@email.com',
      mobile: '+15551234567',
      password: 'foobar',
      password_confirmation: 'foobar'
    )
  end

  test "first_name should not be too short" do
    @user.first_name = "a" * 1
    assert_not @user.valid?
  end

  test "first_name should not be too long" do
    @user.first_name = "a" * 26
    assert_not @user.valid?
  end

  test "last_name should not be too short" do
    @user.last_name = "a" * 1
    assert_not @user.valid?
  end

  test "last_name should not be too long" do
    @user.last_name = "a" * 26
    assert_not @user.valid?
  end

  test 'country should not be too short' do
    @user.country = "a" * 3
    assert_not @user.valid?
  end

  test 'country should not be too long' do
    @user.country = "a" * 57
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "JohnSmith@eMail.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test 'mobile should not be too short' do
    @user.mobile = "a" * 9
    assert_not @user.valid?
  end

  test 'mobile should not be too long' do
    @user.mobile = "a" * 16
    assert_not @user.valid?
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?('')
  end
end
