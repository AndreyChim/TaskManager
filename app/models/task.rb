class Task < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :assignee, class_name: 'User', optional: true
  validates :name, :description, :author, presence: true
  validates :description, length: { maximum: 500 }

  state_machine initial: :new_task do
    event :to_develop do
      transition new_task: :in_development
    end

    event :to_archiv do
      transition new_task: :archived
    end

    event :to_test do
      transition in_development: :in_qa
    end

    event :to_refactoring do
      transition in_qa: :in_development
    end

    event :to_review do
      transition in_qa: :in_code_review
    end

    event :to_release do
      transition in_code_review: :ready_for_release
    end

    event :to_review_refactoring do
      transition in_code_review: :in_development
    end

    event :to_release do
      transition ready_for_release: :released
    end

    event :to_archiv do
      transition released: :archived
    end
  end
end
