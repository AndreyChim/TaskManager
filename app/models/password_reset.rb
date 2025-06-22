class PasswordReset < ApplicationRecord
  belongs_to :user

  before_create :generate_token
  validates :token, uniqueness: true

  after_create :trigger_password_reset_email

  def still_valid?
    expires_at > Time.current
  end

  def mark_used!
    update!(used: true)
  end

  private

  def generate_token
    self.token = SecureRandom.urlsafe_base64(20)
  end

  def trigger_password_reset_email
    PasswordResetEmailSender.call(self)
  end
end