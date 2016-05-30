
# frozen_string_literal: true
FactoryGirl.define do
  factory :importable_account, class: Budget::ImportableAccount do
    name 'MyAccount'
    sequence(:source_id)
  end
end
