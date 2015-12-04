
income = Budget::Category.find_or_create_by(name: 'Income')
expense = Budget::Category.find_or_create_by(name: 'Expense')
transfers = Budget::Category.find_or_create_by(name: 'Transfers')

Budget::Category.find_or_create_by(name: 'Transfer From', parent_id: transfers.id)
Budget::Category.find_or_create_by(name: 'Transfer To', parent_id: transfers.id)
