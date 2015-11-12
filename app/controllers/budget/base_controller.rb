require 'budget/casts'

module Budget
  class BaseController < ActionController::Base
    include Casts
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
