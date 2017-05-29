# frozen_string_literal: true

module Budget
  class ReviewController < BaseController
    def index
      redirect_to next_review_url
    end
  end
end
