class PasswordReset < ApplicationRecord
  belongs_to :user

  before_create :generate_token
  validates :token, uniqueness: true

  after_create :trigger_password_reset_email

  STATE_PENDING = 'pending'
  STATE_USED = 'used'

  def state
    used? ? STATE_USED : STATE_PENDING
  end

  def pending?
    state == STATE_PENDING
  end

  def used?
    used
  end

  def mark_used!
    return if used?
    update!(used: true)
  end

  def still_valid?
    pending? && expires_at > Time.current
  end

  private

  def generate_token
    self.token = SecureRandom.urlsafe_base64(20)
  end

  def trigger_password_reset_email
    PasswordResetEmailSender.call(self)
  end
end