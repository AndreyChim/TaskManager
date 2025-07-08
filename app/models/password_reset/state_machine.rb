module PasswordReset::StateMachine
  extend ActiveSupport::Concern
  
  included do
    state_machine :state, initial: :pending do
      event :mark_used do
        transition pending: :used
      end
  
      state :pending, value: 'pending'
      state :used, value: 'used'
 
      after_transition to: :used, do: :update_used_timestamp
    end
  end
end