# frozen_string_literal: true

describe Budget::TimePeriod do
  describe '.year' do
    context 'when exclusive' do
      subject { described_class.year(1970, inclusive: false) }

      it_behaves_like 'a time period'

      its(:first) { is_expected.to eq Time.utc(1970, 1, 1, 0, 0, 0) }
      its(:last) { is_expected.to eq Time.utc(1970).at_end_of_year }
    end

    context 'when inclusive' do
      subject { described_class.year(1970, inclusive: true) }

      it_behaves_like 'a time period'

      its(:first) { is_expected.to eq Time.utc(1970, 1, 1, 0, 0, 0) }
      its(:last) { is_expected.to eq Time.utc(1971, 1, 1, 0, 0, 0) }
    end
  end

  describe '.month' do
    context 'when exclusive' do
      subject { described_class.month(1970, 1, inclusive: false) }

      it_behaves_like 'a time period'

      its(:first) { is_expected.to eq Time.utc(1970, 1, 1, 0, 0, 0) }
      its(:last) { is_expected.to eq Time.utc(1970).at_end_of_month }
    end

    context 'when inclusive' do
      subject { described_class.month(1970, 1, inclusive: true) }

      it_behaves_like 'a time period'

      its(:first) { is_expected.to eq Time.utc(1970, 1, 1, 0, 0, 0) }
      its(:last) { is_expected.to eq Time.utc(1970, 2, 1, 0, 0, 0) }
    end
  end

  describe 'day' do
    context 'when exclusive' do
      subject { described_class.day(1970, 1, 1, inclusive: false) }

      it_behaves_like 'a time period'

      its(:first) { is_expected.to eq Time.utc(1970, 1, 1, 0, 0, 0) }
      its(:last) { is_expected.to eq Time.utc(1970, 1, 1).at_end_of_day }
    end

    context 'when inclusive' do
      subject { described_class.day(1970, 1, 1, inclusive: true) }

      it_behaves_like 'a time period'

      its(:first) { is_expected.to eq Time.utc(1970, 1, 1, 0, 0, 0) }
      its(:last) { is_expected.to eq Time.utc(1970, 1, 2, 0, 0, 0) }
    end
  end

  describe 'forever' do
    subject { described_class.forever }

    it_behaves_like 'a time period'

    its(:first) { is_expected.to be < Time.at(0).utc }
    its(:last) { is_expected.to be > 500.years.from_now } # long enough for me to care
  end
end
