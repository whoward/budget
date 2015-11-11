
FactoryGirl.define do
  factory :import_service, class: Budget::ImportService do
    type 'DummyImportService'
  end
end
