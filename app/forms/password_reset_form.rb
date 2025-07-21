class PasswordResetForm
    include ActiveModel::Model
  
    attr_reader :token, :password_reset
    attr_accessor :password, :password_confirmation
    
    validates :password, presence: true,
                         length: { minimum: 6 },
                         confirmation: true
    validate :password_reset_validity

    def initialize(token:)
      @token = token
      @password_reset = PasswordReset.find_by(token: token)
    end
  
    def password_reset_validity
      if password_reset.blank?
        errors.add(:base, 'Invalid token')
      elsif password_reset.expired?
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