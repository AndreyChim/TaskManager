FactoryBot.define do
  factory :task do
    name
    description
    author_id { 1 }
    assignee_id { 1 }
    state
    expired_at { Date.today + 7.days}
  end
end
