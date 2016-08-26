# frozen_string_literal: true

describe Budget::Calculator::CategorizedTotals, database_cleaning_strategy: :truncation do
  subject { described_class.new(transactions_dataset: txns, categories_dataset: cats) }

  let(:txns) { Budget::ExpenseRecord.dataset }
  let(:cats) { Budget::CategoryRecord.non_fixture }

  describe '#result' do
    subject { super().result }

    let!(:category) { create(:category, :unbudgeted) }

    context 'and some transactions in this category' do
      let!(:txn_a) { create(:expense, category: category, cents: 100) }
      let!(:txn_b) { create(:expense, category: category, cents: 150) }

      it { is_expected.to eq(category.id => 250) }
    end

    context 'and no transactions in this category' do
      it { is_expected.to eq(category.id => 0) }
    end

    context 'when there are records which dont match the passed dataset' do
      let!(:txn_a) { create(:income, category: category, cents: 100) }

      it { is_expected.to eq(category.id => 0) }
    end

    context 'when using a different category relation' do
      let(:cats) { Budget::CategoryRecord.non_fixture.budgeted }

      let!(:budgeted) { create(:category, :budgeted) }

      it { is_expected.to eq(budgeted.id => 0) }
    end
  end
end
