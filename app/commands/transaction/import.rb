# frozen_string_literal: true

module Budget::Command
  module Transaction
    class Import
      def initialize(importable_transaction, params)
        @importable_transaction = importable_transaction
        @params = params
      end

      def call
        DB.transaction do
          transaction.save
          importable_transaction.update(imported_id: transaction.id)
          record_category_import!
        end
      end

      private

      attr_reader :importable_transaction, :params

      def transaction
        @transaction ||= TransactionRecord.new(params)
      end

      def record_category_import!
        return unless importable_transaction.category.present?

        importable_category.update(import_count: Sequel.+(:import_count, 1))
      end

      def importable_category
        @importable_category ||= ImportableCategoryRecord.find_or_create(
          name: importable.category,
          imported_id: transaction.category_id
        )
      end
    end
  end
end
