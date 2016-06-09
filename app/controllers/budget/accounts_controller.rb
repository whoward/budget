# frozen_string_literal: true

module Budget
  class AccountsController < BaseController
    before_action :set_account, only: %w(edit update destroy)

    def index
      render :index, locals: {
        collection: AccountDecorator.decorate_collection(Account.all)
      }
    end

    def new
      @account = Account.new
    end

    def edit
    end

    def create
      @account = Account.new(account_params)

      if @account.save
        redirect_to action: :index, notice: 'Account was successfully created.'
      else
        render action: 'new'
      end
    end

    def update
      if @account.update(account_params)
        redirect_to action: :index, notice: 'Account was successfully updated.'
      else
        render action: 'edit'
      end
    end

    def destroy
      @account.destroy
      redirect_to accounts_url
    end

    private

    def set_account
      @account = Account.find(params[:id])
    end

    def account_params
      params.require(:account).permit(:name, :debt)
    end
  end
end
