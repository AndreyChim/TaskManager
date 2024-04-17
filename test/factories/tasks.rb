FactoryBot.define do
  factory :task do
    name
    description { "MyText" }
    author_id { 1 }
    assignee_id { 1 }
    state
    expired_at { Date.today }
  end
end
