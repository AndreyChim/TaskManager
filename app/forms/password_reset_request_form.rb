class PasswordResetRequestForm
    include ActiveModel::Model
  
    attr_accessor :email
  
    validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    
    def save
      return false unless valid?
      user = User.find_by(email: email)
      return false unless user.present?
  
      password_reset = user.password_resets.create!(
        expires_at: 24.hours.from_now,
        used: false
      )
      UserMailer.password_reset(user, password_reset).deliver_now
      true
    end
end