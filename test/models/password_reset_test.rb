require "test_helper"

class PasswordResetTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @reset = PasswordReset.create(user: @user)
  end

  test "requires user association" do
    reset = PasswordReset.new(user: nil)
    assert_not reset.valid?
    assert_includes reset.errors[:user], "must exist"
  end

  test "generates unique token on creation" do
    assert_not_nil @reset.token
    duplicate = PasswordReset.new(user: @user, token: @reset.token)
    assert_not duplicate.valid?
  end

  test "expiration status" do
    assert_not @reset.expired?
    @reset.update!(created_at: 2.hours.ago)
    assert @reset.expired?
  end

  test "find_valid method" do
    found = PasswordReset.find_valid(@reset.token)
    assert_equal @reset, found
    
    @reset.update!(created_at: 2.hours.ago)
    assert_nil PasswordReset.find_valid(@reset.token)
    
    assert_nil PasswordReset.find_valid("invalid_token")
    
    fresh_reset = PasswordReset.create(user: @user)
    fresh_reset.consume!
    assert_nil PasswordReset.find_valid(fresh_reset.token)
  end

  test "consumption" do
    assert_not @reset.consumed?
    @reset.consume!
    assert @reset.consumed?
  end
end