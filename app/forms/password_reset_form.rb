class PasswordResetForm
    include ActiveModel::Model
  
    attr_accessor :token, :password, :password_confirmation, :reset
  
    validates :password, presence: true, length: { minimum: 6 }
    validates :password_confirmation, presence: true
    validate :passwords_match
    validate :reset_valid

    def initialize(token:)
      @token = token
      @reset = Admin.find_by(reset_token: token)
    end
  
    def passwords_match
      return if password == password_confirmation
      errors.add(:password_confirmation, "doesn't match Password")
    end
  
    def reset_valid
      self.reset = PasswordReset.find_by(token: token)
      
      if reset.blank?
        errors.add(:base, 'Invalid token')
      elsif !reset.still_valid?
        errors.add(:base, 'Token has expired')
      end
    end
  
    def save
      return false unless valid?
      reset.user.update!(password: password)
      reset.mark_used!
      true
    end
end