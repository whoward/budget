# frozen_string_literal: true
require 'rails_helper'

describe Budget::SplitIncomeTransaction do
  describe '#destroy' do
    let!(:transaction) { create(:split_income, cents: 100) }
    let!(:a) { create(:income, split_transaction: transaction, cents: 20) }
    let!(:b) { create(:income, split_transaction: transaction, cents: 80) }

    it 'destroys the associated splits' do
      expect { transaction.destroy }.to change(Budget::Transaction, :count).by(-3)

      expect { a.reload }.to raise_error ActiveRecord::RecordNotFound
      expect { b.reload }.to raise_error ActiveRecord::RecordNotFound
    end
  end
end
