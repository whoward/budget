# frozen_string_literal: true

module Budget
  module Command
    module Account
      class Update
        def initialize(account, params)
          @account = Cast::AccountRecord(account)
          @params = params
        end

        def call
          account.update(params)
        end

        private

        attr_reader :account, :params
      end
    end
  end
end
