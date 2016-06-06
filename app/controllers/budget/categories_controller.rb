# frozen_string_literal: true
module Budget
  class CategoriesController < BaseController
    before_action :set_category, only: [:show, :edit, :update, :destroy]

    def index
      @categories = Category.order(watched: :desc)
    end

    def new
      @category = Category.new
    end

    def edit
    end

    def create
      @category = Category.new(category_params)

      if @category.save
        redirect_to action: :index, notice: 'Category was successfully created.'
      else
        render action: 'new'
      end
    end

    def update
      if @category.update(category_params)
        redirect_to action: :index, notice: 'Category was successfully updated.'
      else
        render action: 'edit'
      end
    end

    def destroy
      @category.destroy
      redirect_to action: :index
    end

    private

    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:parent_id, :name, :budgeted_cents, :watched)
    end
  end
end
