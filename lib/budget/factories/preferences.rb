
FactoryGirl.define do
  factory :preference, class: Budget::Preference do
    owner(factory: :import_service)
    key 'foo'
    value 'bar'
  end
end
