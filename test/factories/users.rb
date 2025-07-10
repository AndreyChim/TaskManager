FactoryBot.define do
  factory :user do
    first_name
    last_name
    password
    sequence(:email)  { |n| "person#{n}@example.com" }
    email
    avatar
    type { '' }

    factory :admin do
      type { 'Admin' }
    end

    factory :developer do
      type { 'Developer' }
    end

    factory :manager do
      type { 'Manager' }
    end
  end
end
