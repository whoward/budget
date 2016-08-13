# frozen_string_literal: true

describe Budget::Cast, '::Cents' do
  subject { described_class::Cents(value) }

  context 'given an integer' do
    let(:value) { 1_000 }
    it { is_expected.to eq 1_000 }
  end

  context 'given a floating point number which should round down' do
    let(:value) { 1.234 }
    it { is_expected.to eq 123 }
  end

  context 'given a floating point number which should round up' do
    let(:value) { 2.345 }
    it { is_expected.to eq 235 }
  end

  context 'given a dollar and cents string' do
    let(:value) { '123.45' }
    it { is_expected.to eq 12_345 }
  end

  context 'given a cents string' do
    let(:value) { '123' }
    it { is_expected.to eq 123 }
  end
end
