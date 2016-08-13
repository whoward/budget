# frozen_string_literal: true

describe Budget::Account do
  describe '.debt' do
    subject { described_class.debt }

    let!(:a) { create(:account, :debt) }
    let!(:b) { create(:account) }

    it { is_expected.to eq [a] }
  end

  describe '#destroy' do
    let!(:account) { create(:account) }

    context 'when there are related transactions' do
      let!(:txn) { create(:transaction, account: account) }

      it 'prevents deletion' do
        expect { account.destroy }.to raise_error ActiveRecord::DeleteRestrictionError
      end
    end

    context 'with no related transactions' do
      it 'allows deletion' do
        expect { account.destroy }.not_to raise_error
      end
    end
  end

  describe '#transactions_count' do
    subject { account.transactions_count }

    let!(:account) { create(:account) }
    let!(:txn) { create(:transaction, account: account) }

    it { is_expected.to eq 1 }
  end
end
