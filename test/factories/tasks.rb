FactoryBot.define do
  factory :task do
    name
    description
    author factory: :manager
    assignee factory: :manager
    expired_at { Date.today + 7.days }
  end
end
