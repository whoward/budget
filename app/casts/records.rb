# frozen_string_literal: true

module Budget
  module Cast
    define_record_cast :AccountRecord
    define_record_cast :CategoryRecord
    define_record_cast :ImportableAccountRecord
    define_record_cast :ImportServiceRecord
    define_record_cast :TransactionRecord
  end
end
