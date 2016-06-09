# frozen_string_literal: true

module Budget
  class ApplicationDecorator < Draper::Decorator
    def self.collection_decorator_class
      PaginatingDecorator
    end
  end
end
