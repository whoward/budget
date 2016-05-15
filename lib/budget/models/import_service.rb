# frozen_string_literal: true
require 'set'

module Budget
  class ImportService < ActiveRecord::Base
    include Preferable

    def self.registry
      @registry ||= Set.new
    end

    def self.register(service)
      registry << service
    end

    def self.inherited(base)
      base.define_singleton_method(:description) { model_name.human }
      super
    end

    validates :type, inclusion: { in: -> (_) { registry.map(&:name) } }

    scope :active, -> { where(active: true) }
  end
end
