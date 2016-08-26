# frozen_string_literal: true

shared_examples 'a time period' do
  it { is_expected.to be_a(Range) }

  describe '#first' do
    subject { super().first }
    it { is_expected.to be_a(Time) }
  end

  describe '#last' do
    subject { super().last }
    it { is_expected.to be_a(Time) }
  end

  it 'has a larger finish than start' do
    expect(subject.last).to be > subject.first
  end
end
