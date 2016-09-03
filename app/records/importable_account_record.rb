# frozen_string_literal: true

module Budget
  class ImportableAccountRecord < Sequel::Model(:budget_importable_accounts)
    plugin :timestamps, update_on_create: true

    def_dataset_method(:not_imported) { where(imported_id: nil) }
    def_dataset_method(:imported) { exclude(imported_id: nil) }
  end
end
