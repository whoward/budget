# frozen_string_literal: true

describe Budget::MonthEnumerator do
  subject { described_class.new(start_year, start_month, end_year: end_year, end_month: end_month) }

  describe '.since_first_transaction' do
    subject { described_class.since_first_transaction }

    context 'when there are no transactions in the system' do
      before { expect(Budget::TransactionRecord).to receive(:min).with(:date).and_return(nil) }

      its(:start) { is_expected.to eq Time.zone.today.at_beginning_of_month }
      its(:final) { is_expected.to eq Time.zone.today.at_beginning_of_month }
    end

    context 'when there is some transaction in the system' do
      before { expect(Budget::TransactionRecord).to receive(:min).with(:date).and_return(first) }

      let(:first) { Date.new(2010, 1, 11) }

      its(:start) { is_expected.to eq first.at_beginning_of_month }
      its(:final) { is_expected.to eq Time.zone.today.at_beginning_of_month }
    end
  end

  describe '#to_a' do
    subject { super().to_a }

    let(:start_year) { 2016 }
    let(:start_month) { 1 }

    let(:end_year) { 2016 }
    let(:end_month) { 3 }

    it { is_expected.to eq [[2016, 1], [2016, 2], [2016, 3]] }
  end
end
