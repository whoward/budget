# frozen_string_literal: true

module Budget
  module HtmlEmailHelper
    def card(&block)
      content_tag(:table, class: 'card') do
        content_tag(:tr) do
          content_tag(:td, capture(&block))
        end
      end
    end
  end
end
