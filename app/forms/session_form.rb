class SessionForm
  include ActiveModel::Model

  attr_accessor :email, :password
  attr_reader :user

  validates :email, presence: true
  validates :password, presence: true
  validate :authenticate_user, if: -> { email.present? && password.present? }

  private

  def authenticate_user
    @user = User.find_by(email: email)
    
    if @user.nil?
      errors.add(:email, "not found")
    elsif !@user.authenticate(password)
      errors.add(:password, "is incorrect")
    end
  end
end
