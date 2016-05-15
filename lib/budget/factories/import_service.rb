
# frozen_string_literal: true
FactoryGirl.define do
  factory :import_service, class: Budget::ImportService do
    type 'DummyImportService'
  end
end
