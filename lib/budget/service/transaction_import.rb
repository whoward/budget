# frozen_string_literal: true
require 'budget/service_response'

module Budget
  module Service
    class TransactionImport
      def initialize(importable, txn, params)
        @importable = importable
        @txn = txn
        @params = params
      end

      def call
        if txn.valid?
          Transaction.transaction do
            txn.save!

            importable.update_attribute :imported_id, txn.id

            if importable.category
              ImportableCategory.find_or_create_by(
                name: importable.category,
                imported_id: txn.category_id
              ).increment!(:import_count)
            end
          end

          ServiceResponse::SUCCESS
        else
          ServiceResponse::FAILURE
        end
      end

      private

      attr_reader :importable, :txn, :params
    end
  end
end
