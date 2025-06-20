class PasswordReset < ApplicationRecord
  belongs_to :user, polymorphic: true

  before_create :generate_token
  validates :token, uniqueness: true

  after_create :send_password_reset_email

  def send_password_reset_email
    UserMailer.password_reset(user, self).deliver_now
  end

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
end