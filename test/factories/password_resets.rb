FactoryBot.define do
  factory :password_reset do
    user { nil }
    token { "MyString" }
    expires_at { "2025-06-03 06:46:23" }
    used { false }
  end
end
