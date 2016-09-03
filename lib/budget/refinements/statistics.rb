# frozen_string_literal: true

module Budget
  module Refinements
    module Statistics
      refine Array do
        def mean
          sum / length.to_f
        end

        def trimmed_mean(percent)
          drop = length / percent
          keep = length - 2 * drop
          sort.slice(drop, keep).mean
        end
      end
    end
  end
end
