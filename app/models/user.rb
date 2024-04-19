class User < ApplicationRecord
  has_secure_password
  has_many :my_tasks, class_name: 'Task', foreign_key: :author_id
  has_many :assigned_tasks, class_name: 'Task', foreign_key: :assignee_id
  validates :first_name, presence: true, length: { minimum: 2 }, format: { with: /\A[a-zA-Z]+\z/,
                                                   message: "first_name can't be less than two letters" }
  validates :last_name, presence: true, length: { minimum: 2 }, format: { with: /\A[a-zA-Z]+\z/,
                                                  message: "last_name can't be less than two letters" }
  validates :email, presence: true, uniqueness: true, format: { with: /@/ } 
end
