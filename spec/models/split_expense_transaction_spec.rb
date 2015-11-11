require 'rails_helper'

describe Budget::SplitExpenseTransaction do
  describe '#destroy' do
    let!(:transaction) { create(:split_expense, cents: 100) }
    let!(:a) { create(:expense, split_transaction: transaction, cents: 20) }
    let!(:b) { create(:expense, split_transaction: transaction, cents: 80) }

    it 'destroys the associated splits' do
      expect { transaction.destroy }.to change(Budget::Transaction, :count).by(-3)

      expect { a.reload }.to raise_error ActiveRecord::RecordNotFound
      expect { b.reload }.to raise_error ActiveRecord::RecordNotFound
    end
  end
end
