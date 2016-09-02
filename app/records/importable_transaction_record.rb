# frozen_string_literal: true

module Budget
  class ImportableTransactionRecord < Sequel::Model(:budget_importable_transactions)
    def_dataset_method(:not_imported) { where(imported_id: nil) }
    def_dataset_method(:imported) { exclude(imported_id: nil) }
  end
end
