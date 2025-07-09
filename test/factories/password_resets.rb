FactoryBot.define do
  factory :password_reset do
    user
    sequence(:token) { |n| "valid_token_#{n}#{SecureRandom.hex(10)}" }
    expires_at { 1.hour.from_now }
    state { 'pending' }

    trait :expired do
      expires_at { 1.hour.ago }
    end

    trait :used do
      state { 'used' }
      used_at { 5.minutes.ago }
    end

    trait :pending do
      state { 'pending' }
      used_at { nil }
    end

    trait :with_known_token do
      token { "known_test_token" }
    end
  end
end