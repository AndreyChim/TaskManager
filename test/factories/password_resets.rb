FactoryBot.define do
  factory :password_reset do
    user
    sequence(:token) { |n| "valid_token_#{n}#{SecureRandom.hex(10)}" }
    expires_at { 1.hour.from_now }
    state { PasswordReset::STATE_PENDING }

    trait :expired do
      expires_at { 1.hour.ago }
    end

    trait :used do
      state { PasswordReset::STATE_USED }
      used_at { 5.minutes.ago }
    end

    trait :pending do
      state { PasswordReset::STATE_PENDING }
      used_at { nil }
    end

    trait :with_known_token do
      token { "known_test_token" }
    end
  end
end