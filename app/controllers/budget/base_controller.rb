
# frozen_string_literal: true
module Budget
  class BaseController < ActionController::Base
    helper Budget::Engine.helpers

    layout 'budget/application'

    protected

    def next_review_url
      obj = ImportableAccount.not_imported.first || ImportableTransaction.not_imported.first

      if obj
        url_for obj
      else
        flash[:notice] = "You're all done! no more stuff to review."
        root_path
      end
    end
  end
end
