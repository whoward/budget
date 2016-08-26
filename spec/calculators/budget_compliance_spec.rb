# frozen_string_literal: true

describe Budget::Calculator::BudgetCompliance, database_cleaning_strategy: :truncation do
  subject { described_class.new(budget) }

  let(:budget) { Budget::MonthlyBudget.new(1970, 1) }

  describe '#result' do
    subject { super().result }

    context 'given a category budgeted for the given month' do
      let!(:category) { create(:category, budgeted_cents: 999) }

      context 'when there are transactions that sum up to <= the budget' do
        let!(:txn) { create(:expense, category: category, cents: 500, date: Time.utc(1970, 1, 15)) }

        it { is_expected.to eq(category.id => 499) }
      end

      context 'when there are transactions that sum up to > the budget' do
        let!(:txn) { create(:expense, category: category, cents: 1_499, date: Time.utc(1970, 1, 15)) }

        it { is_expected.to eq(category.id => -500) }
      end

      context 'when there are no transactions' do
        it { is_expected.to eq(category.id => 999) }
      end

      context 'when there are unbudgeted categories' do
        let!(:unbudgeted) { create(:category, :unbudgeted) }

        it { is_expected.to eq(category.id => 999) }
      end

      context 'when there are transactions outside the time period' do
        let!(:txn) { create(:expense, category: category, cents: 500) }

        it { is_expected.to eq(category.id => 999) }
      end
    end
  end

  describe '#overbudget' do
    subject { super().overbudget }

    let!(:cat_a) { create(:category, budgeted_cents: 999) }
    let!(:cat_b) { create(:category, budgeted_cents: 999) }

    let!(:exp_a) { create(:expense, category: cat_a, cents: 500, date: Time.utc(1970, 1, 15)) } # underbudget
    let!(:exp_b) { create(:expense, category: cat_b, cents: 1000, date: Time.utc(1970, 1, 15)) } # overbudget

    it { is_expected.to eq(cat_b.id => 1) }
  end

  describe '#overbudget_total' do
    subject { super().overbudget_total }

    let!(:cat) { create(:category, budgeted_cents: 700) }

    let!(:exp_a) { create(:expense, category: cat, cents: 500, date: Time.utc(1970, 1, 15)) }
    let!(:exp_b) { create(:expense, category: cat, cents: 1000, date: Time.utc(1970, 1, 15)) }

    it { is_expected.to eq 800 }
  end

  describe '#total_budgeted_spending' do
    subject { super().total_budgeted_spending }

    let!(:cat) { create(:category, budgeted_cents: 700) }

    let!(:exp_a) { create(:expense, category: cat, cents: 500, date: Time.utc(1970, 1, 15)) }
    let!(:exp_b) { create(:expense, category: cat, cents: 1000, date: Time.utc(1970, 1, 15)) }

    it { is_expected.to eq 1500 }
  end
end
