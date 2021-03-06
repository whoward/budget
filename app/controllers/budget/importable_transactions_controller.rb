
# frozen_string_literal: true
module Budget
  class ImportableTransactionsController < BaseController
    def show
      use_duplicate_strategy = params[:duplicate] != 'no'

      @imported_transaction = TransactionFactory.build_with_inference_from_importable_transaction(
        importable_transaction,
        duplicate: use_duplicate_strategy
      )

      if @imported_transaction.new_record? || params[:duplicate] == 'no'
        render 'new'
      elsif importable_transaction.imported_id && params[:reimport] != 'yes'
        render 'already_imported'
      else
        render 'duplicate'
      end
    end

    def update
      if filtered_params[:imported_id].present?
        importable_transaction.update_attribute :imported_id, filtered_params[:imported_id]
        return redirect_to next_review_url
      end

      # TODO: missing features
      # - reject (do not import)
      # - push off for later review
      @imported_transaction = (importable_transaction.expense ? Expense : Income).new(filtered_params)

      if Service::TransactionImport.new(importable_transaction, imported_transaction, filtered_params).call.success?
        redirect_to next_review_url
      else
        render 'new'
      end
    end

    private

    attr_reader :imported_transaction
    helper_method :imported_transaction

    def filtered_params
      params.require(:transaction).permit(:imported_id, :cents, :account_id, :category_id, :date, :description, :notes)
    end

    def importable_transaction
      @_importable_transaction ||= ImportableTransaction.find(params[:id])
    end
    helper_method :importable_transaction

    def root_category
      @_root_category ||= importable_transaction.expense ? Category.expense : Category.income
    end
    helper_method :root_category
  end
end
