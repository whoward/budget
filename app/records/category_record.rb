# frozen_string_literal: true

module Budget
  class CategoryRecord < Sequel::Model(:budget_categories)
    def_dataset_method(:budgeted) { exclude(budgeted_cents: nil) }

    def_dataset_method(:non_fixture) do
      exclude(parent_id: nil).exclude(parent_id: Budget::Category.transfers.id)
    end
  end
end
