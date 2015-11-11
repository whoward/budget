require 'set'
require 'budget/concerns/preferable'

module Budget
  class ImportService < ActiveRecord::Base
    include Preferable

    validates :type, inclusion: { in: -> (_) { subclasses.map(&:name) } }

    scope :active, -> { where(active: true) }

    def self.registry
      @registry ||= Set.new
    end

    def self.register(service)
      registry << service
    end
  end
end
