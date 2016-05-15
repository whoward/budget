
# frozen_string_literal: true
FactoryGirl.define do
  factory :account, class: Budget::Account do
    name 'MyAccount'

    trait :debt do
      debt true
    end

    factory :debt_account, traits: %i(debt)
  end
end
