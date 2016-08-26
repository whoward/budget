# frozen_string_literal: true

# TODO: add levels to it
module Budget
  module HtmlEmail
    class ProgressBar
      def initialize(value:, total:)
        @value = value
        @total = total
      end

      def percent
        (value.to_f / total.to_f * 100).round
      end

      def progress
        [percent, 100].min
      end

      def remaining
        100 - progress
      end

      def to_s
        ERB.new(TEMPLATE).result(binding).html_safe
      end

      private

      TEMPLATE = <<-HTML
        <table class='progress-bar'>
          <tr>
            <td class='progress <%= severity %>' style="width:<%= progress %>%"></td>
            <% if progress < 100 %>
            <td class='progress-remaining' style="width:<%= remaining %>%"></td>
            <% end %>
          </tr>
        </table>
      HTML

      attr_reader :value, :total

      def severity
        case percent
        when 0..24 then :minor
        when 25..49 then :major
        when 50..74 then :critical
        when 75..100 then :severe
        else :exceeded
        end
      end
    end
  end
end
