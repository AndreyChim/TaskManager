class PasswordReset < ApplicationRecord
  belongs_to :user

  before_create :generate_token
  before_create :set_expiration_time
  after_commit :trigger_password_reset_email, on: :create

  validates :token, uniqueness: true

  include PasswordReset::StateMachine

  def still_valid?
    pending? && expires_at && expires_at > Time.current
  end

  private

  def generate_token
    self.token = SecureRandom.urlsafe_base64(20)
  end

  def set_expiration_time
    self.expires_at ||= 24.hours.from_now
  end

  def trigger_password_reset_email
    PasswordResetEmailSender.call(self)
  end
end