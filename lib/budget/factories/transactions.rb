
FactoryGirl.define do
  factory :transaction, class: Budget::Transaction do
    type 'Budget::Expense'
    account
    category
    cents 100
    date { Time.zone.today }
    description 'Tim Hortons'

    factory :expense, class: Budget::Expense

    factory :income, class: Budget::Income do
      type 'Budget::Income'
    end

    factory :transfer_from, class: Budget::TransferFrom do
      type 'Budget::TransferFrom'
    end

    factory :transfer_to, class: Budget::TransferTo do
      type 'Budget::TransferTo'
    end

    factory :split_income, class: Budget::SplitIncomeTransaction do
      type 'Budget::SplitIncomeTransaction'
    end

    factory :split_expense, class: Budget::SplitExpenseTransaction do
      type 'Budget::SplitExpenseTransaction'
    end
  end
end
