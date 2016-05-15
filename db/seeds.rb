
income = Budget::Category.find_or_create_by(name: 'Income', depth: 1)
expense = Budget::Category.find_or_create_by(name: 'Expense', depth: 1)
transfers = Budget::Category.find_or_create_by(name: 'Transfers', depth: 1)

Budget::Category.find_or_create_by(name: 'Transfer From', parent_id: transfers.id, depth: 2)
Budget::Category.find_or_create_by(name: 'Transfer To', parent_id: transfers.id, depth: 2)
