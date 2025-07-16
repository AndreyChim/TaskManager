module PasswordReset::StateMachine
  extend ActiveSupport::Concern
  
  included do
    STATE_PENDING = :pending
    STATE_USED = :used

    state_machine :state, initial: STATE_PENDING do
      event :mark_used do
        transition STATE_PENDING => STATE_USED
      end
  
      after_transition to: STATE_USED, do: :update_used_timestamp
    end
  end

  private

  def update_used_timestamp
    self.used_at = Time.current
  end
end