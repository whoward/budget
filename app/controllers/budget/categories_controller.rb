# frozen_string_literal: true

module Budget
  class CategoriesController < BaseController
    def index
      render :index, locals: {
        income: Budget::CategoryDecorator.decorate_collection(
          CategoryRecord.income.descendants.order(:name)
        ),
        expenses: Budget::CategoryDecorator.decorate_collection(
          CategoryRecord.expense.descendants.order(:name)
        )
      }
    end

    def new
      @category = CategoryRecord.new
    end

    def edit
      @category = Cast::CategoryRecord(params[:id])
    end

    def create
      Command::Category::Create.new(category_params).call
      flash[:notice] = 'Category was successfully created.'
      redirect_to :index
    end

    def update
      Command::Category::Update.new(params[:id], category_params).call
      flash[:notice] = 'Category was successfully updated.'
      redirect_to :index
    end

    def destroy
      Command::Category::Destroy.new(params[:id]).call
      redirect_to :index
    end

    private

    def category_params
      params.require(:category).permit(:parent_id, :name, :budgeted_cents, :watched)
    end
  end
end
