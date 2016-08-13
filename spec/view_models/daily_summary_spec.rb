# frozen_string_literal: true

describe Budget::DailySummary do
  subject { summary }

  let(:summary) { described_class.new(date: date) }

  let(:date) { Date.new(2000, 1, 1) }

  describe '#budget' do
    subject { super().budget }

    it { is_expected.to be_a Budget::MonthlyBudget }
    its(:year) { is_expected.to eq 2000 }
    its(:month) { is_expected.to eq 1 }
  end

  describe '#compliance' do
    subject { super().compliance }

    it { is_expected.to be_a Budget::Calculator::BudgetCompliance }

    its(:budget) { is_expected.to eq summary.budget }
  end

  describe '#day_in_month' do
    subject { super().day_in_month }
    it { is_expected.to eq 1 }
  end

  describe '#days_in_month' do
    subject { super().days_in_month }
    it { is_expected.to eq 31 }
  end

  describe '#days_remaining' do
    subject { super().days_remaining }
    it { is_expected.to eq 30 }
  end

  describe '#overbudget?' do
    subject { super().overbudget? }

    before { allow(summary.compliance).to receive(:overbudget_total).and_return(total) }

    context 'when the compliances overbudget total is positive' do
      let(:total) { 1 }
      it { is_expected.to eq true }
    end

    context 'when the compliances overbudget total is zero' do
      let(:total) { 0 }
      it { is_expected.to eq false }
    end

    context 'when the compliances overbudget total is negative' do
      let(:total) { -1 }
      it { is_expected.to eq false }
    end
  end
end
