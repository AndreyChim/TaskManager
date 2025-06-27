class PasswordReset < ApplicationRecord
  belongs_to :user

  before_create :generate_token
  before_create :set_expiration_time
  after_create :trigger_password_reset_email

  validates :token, uniqueness: true

  state_machine :state, initial: :pending do
    before_save :initialize_state, if: :new_record?

    event :mark_used do
      transition pending: :used
    end

    state :pending, value: 'pending'
    state :used, value: 'used'

    after_transition to: :used, do: :update_used_timestamp
  end

  def still_valid?
    pending? && expires_at && expires_at > Time.current
  end

  private

  def initialize_state
    self.state ||= 'pending'
  end
  
  def generate_token
    self.token = SecureRandom.urlsafe_base64(20)
  end

  def set_expiration_time
    self.expires_at ||= 24.hours.from_now
  end

  def trigger_password_reset_email
    PasswordResetEmailSender.call(self)
  end

  def update_used_timestamp
    update(used_at: Time.current)
  end
end