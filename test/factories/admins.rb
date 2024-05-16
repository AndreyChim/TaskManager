FactoryBot.define do
  factory :admin do
    sequence :first_name do |n|
      "FN#{n}"
    end

    sequence :last_name do |n|
      "LN#{n}"
    end

    sequence :password do |n|
      "#{n}"
    end

    sequence :email do |n|
      "email#{n}@mail.gen"
    end
  end
end
