
# frozen_string_literal: true
module Budget
  module Reports
    class CategorySpendingController < BaseController
      def index
        @income_categories = Category.income.descendants.order(:name)
        @expense_categories = Category.expense.descendants.order(:name)
      end

      def show
        @category = Category.find(params[:category_id])
        @report = Report::CategoricalSpending.new(@category)
      end
    end
  end
end
