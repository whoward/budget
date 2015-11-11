
FactoryGirl.define do
  factory :transaction, class: Budget::Transaction do
    type 'Budget::Expense'
    account
    category
    cents 100
    date { Time.zone.today }
    description 'Tim Hortons'
  end

  factory :expense, parent: :transaction, class: Budget::Expense

  factory :income, parent: :transaction, class: Budget::Income do
    type 'Budget::Income'
  end

  factory :transfer_from, parent: :transaction, class: Budget::TransferFrom do
    type 'Budget::TransferFrom'
  end

  factory :transfer_to, parent: :transaction, class: Budget::TransferTo do
    type 'Budget::TransferTo'
  end

  factory :split_income, parent: :transaction, class: Budget::SplitIncomeTransaction do
    type 'Budget::SplitIncomeTransaction'
  end

  factory :split_expense, parent: :transaction, class: Budget::SplitExpenseTransaction do
    type 'Budget::SplitExpenseTransaction'
  end
end
