# frozen_string_literal: true

module Budget
  class AccountRecord < Sequel::Model(:budget_accounts)
    plugin :timestamps, update_on_create: true
  end
end
