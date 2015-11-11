require 'budget/casts'

module Budget
  class ApplicationController < ActionController::Base
    include Casts
  end
end
