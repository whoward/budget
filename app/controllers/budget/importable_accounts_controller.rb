# frozen_string_literal: true

module Budget
  class ImportableAccountsController < BaseController
    def show
      # TODO: check if the account is already imported and if so render a different page
      account # force load
    end

    def update
      Command::Account::Import.new(account, filtered_params).call
      redirect_to next_review_url
    end

    private

    def filtered_params
      params.require(:importable_account).permit(:name)
    end

    def account
      @_account ||= Cast::ImportableAccountRecord(params[:id])
    end
    helper_method :account
  end
end
