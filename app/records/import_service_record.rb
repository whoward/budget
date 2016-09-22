# frozen_string_literal: true

require 'set'

module Budget
  class ImportServiceRecord < Sequel::Model(:budget_import_services)
    plugin :validation_helpers

    def_dataset_method(:active) { where(active: true) }

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

    # def validate
    #   super
    #   validates_includes ImportServiceRecord.registry.map(&:name), :type
    # end
  end
end
