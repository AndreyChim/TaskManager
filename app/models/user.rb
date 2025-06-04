class User < ApplicationRecord
  has_secure_password
  has_many :my_tasks, class_name: 'Task', foreign_key: :author_id
  has_many :assigned_tasks, class_name: 'Task', foreign_key: :assignee_id
  has_many :password_resets, dependent: :destroy
  validates :first_name, :last_name, presence: true, length: { minimum: 2 }
  validates :email, presence: true, uniqueness: true, format: { with: /@/ }

  def create_password_reset!
    password_resets.update_all(used: true) # Invalidate previous tokens
    password_resets.create!(expires_at: 24.hours.from_now)
  end
end