class PasswordReset < ApplicationRecord
  belongs_to :user

  before_create :generate_token
  validates :token, uniqueness: true

  after_create :trigger_password_reset_email

  # State machine definition
  state_machine :state, initial: :pending do
    event :mark_used do
      transition pending: :used
    end

    state :pending, value: 'pending'
    state :used, value: 'used'

    after_transition to: :used, do: :update_used_timestamp
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

   # Callback to update timestamp when marked used
  def update_used_timestamp
    update(used_at: Time.current)
  end
end