require 'factory_bot'

FactoryBot.define do
    sequence :string, aliases: [:first_name, :last_name, :password, :name, :state] do |n|
      "string#{n}"
    end
    sequence(:email)  { |n| "person#{n}@example.com" }
    sequence(:avatar) { |n| "avatar#{n}" }
end
  