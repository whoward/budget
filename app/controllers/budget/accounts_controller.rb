# frozen_string_literal: true

module Budget
  class AccountsController < BaseController
    def index
      render :index, locals: {
        collection: AccountDecorator.decorate_collection(Account.to_a)
      }
    end

    def new
      @account = AccountRecord.new
    end

    def edit
      @account = Cast::AccountRecord(params[:id])
    end

    def create
      Command::Account::Create.new(account_params).call
      flash[:notice] = 'Account was successfully created.'
      redirect_to :index
    end

    def update
      Command::Account::Update.new(params[:id], account_params).call
      flash[:notice] = 'Account was successfully updated.'
      redirect_to :index
    end

    def destroy
      Command::Account::Delete.new(params[:id]).call
      redirect_to accounts_url
    end

    private

    def account_params
      params.require(:account).permit(:name, :debt)
    end
  end
end
