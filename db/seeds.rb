# frozen_string_literal: true

_income = Budget::CategoryRecord.find_or_create(name: 'Income')
_expense = Budget::CategoryRecord.find_or_create(name: 'Expense')
transfers = Budget::CategoryRecord.find_or_create(name: 'Transfers')

Budget::CategoryRecord.find_or_create(name: 'Transfer From', parent_id: transfers.id)
Budget::CategoryRecord.find_or_create(name: 'Transfer To', parent_id: transfers.id)
