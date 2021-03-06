# frozen_string_literal: true

require 'sequel'

module Budget
  module DB
    module_function

    def method_missing(method, *args, &block)
      return super unless connection.respond_to?(method)

      connection.public_send(method, *args, &block)
    end

    def connection
      @connection ||= begin
        db = Sequel.connect(ActiveRecord::Base.connection_config)
        db.loggers << Rails.logger
        db.sql_log_level = :debug

        Sequel::Model.db = db

        db
      end
    end
  end
end
