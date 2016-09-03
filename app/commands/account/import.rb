# frozen_string_literal: true

module Budget::Command
  module Account
    class Import
      def initialize(importable_account, params)
        @importable_account = importable_account
        @params = params
      end

      def call
        account = AccountRecord.new(params)

        DB.transaction do
          account.save
          importable_account.update(imported_id: account.id)
        end

        account
      end

      private

      attr_reader :importable_account, :params
    end
  end
end
