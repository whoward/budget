# frozen_string_literal: true

FactoryGirl.define do
  factory :importable_transaction, class: Budget::ImportableTransaction do
    importable_account
    sequence(:source_id)
    expense true
    date { Time.zone.today }
    cents 10_00
  end
end
