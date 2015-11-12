module Budget
  class AccountsController < BaseController
    before_action :set_account, only: [:show, :edit, :update, :destroy]

    def index
      @accounts = Account.all
    end

    def show
    end

    def new
      @account = Account.new
    end

    def edit
    end

    def create
      @account = Account.new(account_params)

      respond_to do |format|
        if @account.save
          format.html { redirect_to @account, notice: 'Account was successfully created.' }
          format.json { render action: 'show', status: :created, location: @account }
        else
          format.html { render action: 'new' }
          format.json { render json: @account.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @account.update(account_params)
          format.html { redirect_to @account, notice: 'Account was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @account.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @account.destroy
      respond_to do |format|
        format.html { redirect_to accounts_url }
        format.json { head :no_content }
      end
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
