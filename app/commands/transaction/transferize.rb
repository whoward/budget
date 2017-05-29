# frozen_string_literal: true

module Budget
  module Command
    class Transferize
      def initialize(from, to)
        @from = Cast::TransactionRecord(from)
        @to = Cast::TransactionRecord(to)
      end

      def call
        validate!

        DB.transaction do
          update_from!
          update_to!
        end
      end

      private

      attr_reader :from, :to

      def validate!
        TransferizePolicy.new(from, to).validate
      end

      def update_from!
        from.update category_id: CategoryRecord.transfer_from.id,
                    type: 'Budget::TransferFrom',
                    transfer_id: to.id
      end

      def update_to!
        to.update category_id: CategoryRecord.transfer_to.id,
                  type: 'Budget::TransferTo',
                  transfer_id: from.id
      end
    end
  end
end
