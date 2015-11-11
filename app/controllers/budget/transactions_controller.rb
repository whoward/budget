require 'budget/transferize_policy'

module Budget
  class TransactionsController < ApplicationController
    def index
    end

    def edit
      @transaction = Transaction.find(params[:id])
    end

    def edit_split
      @transaction = Transaction.find(params[:id])
      render 'split'
    end

    def update
      @transaction = Transaction.find(params[:id])

      if @transaction.update(filtered_params)
        redirect_to params[:return_to].presence || transactions_path, notice: 'Transaction updated'
      else
        render action: 'edit'
      end
    end

    def transferize
      from = Transaction.find(params[:from_id])
      to = Transaction.find(params[:to_id])

      if (reason = TransferizePolicy.new(from, to).validate) == true
        Service::Transferize.new(from, to).call
        render json: {}, status: :ok
      else
        render json: { reason: reason }, status: :bad_request
      end
    end

    def split
      txn = Transaction.find(params[:id])

      parts = params.require(:partitions).map do |part|
        attrs = part.permit(:category_id, :cents, :notes)
        inherited = txn.attributes.slice('account_id', 'date', 'description')

        attrs[:cents] = Cents(attrs[:cents])

        klass = txn.is_a?(Expense) ? Expense : Income

        klass.new(attrs.merge(inherited))
      end

      result = Budget::Service::SplitTransactionSave.new(transaction: txn, partitions: parts).call

      if result.success?
        render json: { success: true }
      else
        render json: { success: false, reason: result.reason }, status: :bad_request
      end
    end

    private

    def filtered_params
      params.require(:transaction).permit(:category_id, :notes)
    end

    def scope
      Transaction.order('date desc, cents desc, type desc, id asc')
        .includes(:account, :category)
        .not_split_transactions
    end

    def query
      @query ||= scope.ransack(params[:q])
    end
    helper_method :query

    def collection
      query.result.page(params.fetch(:page, 1)).per(50)
    end
    helper_method :collection

    def root_category
      @_root_category ||= @transaction.is_a?(Expense) ? Category.expense : Category.income
    end
    helper_method :root_category
  end
end
