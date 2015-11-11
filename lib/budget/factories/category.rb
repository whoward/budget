
FactoryGirl.define do
  factory :category, class: Budget::Category do
    parent_id { Budget::Category.expense.id }
    name 'Restaurant'

    trait :expense

    trait :income do
      parent_id { Budget::Category.income.id }
    end

    trait :unbudgeted

    trait :budgeted do
      budgeted_cents 1000
    end

    factory :expense_category, traits: %i(expense)

    factory :income_category, traits: %i(income)
  end
end
