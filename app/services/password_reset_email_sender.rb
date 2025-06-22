class PasswordResetEmailSender
  def self.call(password_reset)
    UserMailer.password_reset(password_reset.user, password_reset).deliver_later
  end
end