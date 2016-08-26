
# frozen_string_literal: true
module Budget
  class Preference < ActiveRecord::Base
    belongs_to :owner, polymorphic: true

    validates :owner, presence: true
    validates :key, presence: true
    validates :value, presence: true

    serialize :value
  end
end
