# frozen_string_literal: true

module Budget
  module Command
    module Account
      class Delete
        def initialize(account)
          @account = Cast::AccountRecord(account)
        end

        def call
          account.destroy
        end

        private

        attr_reader :account
      end
    end
  end
end
