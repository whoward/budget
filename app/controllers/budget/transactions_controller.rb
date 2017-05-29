# frozen_string_literal: true
module Budget
  class TransactionsController < BaseController
    def index
      render :index, locals: {
        collection: Budget::TransactionDecorator.decorate_collection(collection)
      }
    end

    def edit
      @transaction = Cast::TransactionRecord(params[:id])
    end

    def edit_split
      @transaction = Cast::TransactionRecord(params[:id])
      render 'split'
    end

    def update
      @transaction = Cast::TransactionRecord(params[:id])

      if @transaction.update(filtered_params)
        redirect_to params[:return_to].presence || transactions_path, notice: 'Transaction updated'
      else
        render action: 'edit'
      end
    end

    def transferize
      Command::Transaction::Transferize.new(params[:from_id], params[:to_id]).call
      render json: {}, status: :ok
    rescue ArgumentError => e
      render json: { reason: e.message }, status: :bad_request
    end

    def split
      Command::Transaction::Split.new(params[:id], params.require(:partitions)).call
      render json: { success: true }
    rescue ArgumentError => e
      render json: { success: false, reason: e.message }, status: :bad_request
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

    def root_category
      @_root_category ||= @transaction.is_a?(Expense) ? Category.expense : Category.income
    end
    helper_method :root_category
  end
end
