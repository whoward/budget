# frozen_string_literal: true

describe Budget::Calculator::DaysInPeriod do
  subject { described_class.new(period) }

  describe '#result' do
    subject { super().result }

    context 'within the same day' do
      let(:period) { Budget::TimePeriod.day(1970, 1, 1) }

      it { is_expected.to eq 0 }
    end

    context 'for a month' do
      let(:period) { Budget::TimePeriod.month(1970, 1, inclusive: true) }

      it { is_expected.to eq 31 }
    end

    context 'for a couple years' do
      let(:period) { Time.utc(1970)..Time.utc(1972) }

      it { is_expected.to eq 365 * 2 }
    end
  end
end
