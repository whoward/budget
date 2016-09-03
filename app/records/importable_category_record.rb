# frozen_string_literal: true

module Budget
  class ImportableCategoryRecord < Sequel::Model(:budget_importable_categories)
    plugin :timestamps, update_on_create: true
  end
end
