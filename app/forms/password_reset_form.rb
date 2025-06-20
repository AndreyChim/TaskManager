class PasswordResetForm
    include ActiveModel::Model
  
    attr_accessor :token, :password, :password_confirmation
    attr_reader :password_reset
  
    validates :password, presence: true, length: { minimum: 6 }
    validates :password_confirmation, presence: true
    validate :passwords_match
    validate :password_reset_valid

    def initialize(token:)
      @token = token
      @password_reset = PasswordReset.find_by(token: token)
    end
  
    def passwords_match
      return if password == password_confirmation
      errors.add(:password_confirmation, "doesn't match Password")
    end
  
    def password_reset_valid
      if password_reset.blank?
        errors.add(:base, 'Invalid token')
      elsif !password_reset.still_valid?
        errors.add(:base, 'Token has expired')
      end
    end
  
    def save
      return false unless valid?
      password_reset.user.update!(password: password)
      password_reset.mark_used!
      true
    end
end