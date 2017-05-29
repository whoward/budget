# frozen_string_literal: true

module Budget
  class BaseController < ActionController::Base
    helper Budget::Engine.helpers

    layout 'budget/application'

    protected

    def next_review_url
      if (obj = ImportableAccountRecord.not_imported.first)
        importable_account_path(obj)
      elsif (obj = ImportableTransactionRecord.not_imported.first)
        importable_transaction_path(obj)
      else
        flash[:notice] = "You're all done! no more stuff to review."
        root_path
      end
    end
  end
end
