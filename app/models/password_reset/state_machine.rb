module PasswordReset::StateMachine
  extend ActiveSupport::Concern
  
  included do
    state_machine :state, initial: :pending do
      event :mark_used do
        transition pending: :used
      end
  
      after_transition to: :used, do: :update_used_timestamp
    end
  end

  private

  def update_used_timestamp
    self.used_at = Time.current
  end
end