require 'rails_helper'

describe Budget::Transaction do
  describe 'validation' do
    it 'requires an account' do
      expect(build(:transaction, account: nil)).not_to be_valid
    end

    it 'requires a category' do
      expect(build(:transaction, category: nil)).not_to be_valid
    end

    it 'requires the amount' do
      expect(build(:transaction, cents: nil)).not_to be_valid
    end

    it 'requires the date' do
      expect(build(:transaction, date: nil)).not_to be_valid
    end

    it 'requires a description' do
      expect(build(:transaction, description: nil)).not_to be_valid
    end
  end

  describe '.not_split_transactions' do
    subject { described_class.not_split_transactions }

    let!(:a) { create(:expense) }
    let!(:b) { create(:split_expense) }
    let!(:c) { create(:split_income) }

    it { is_expected.to eq [a] }
  end

  describe '#signed_cents' do
    subject { transaction.signed_cents }

    context 'given an expense' do
      let(:transaction) { build(:expense, cents: 1000) }
      it { is_expected.to eq(-1000) }
    end

    context 'given income' do
      let(:transaction) { build(:income, cents: 1000) }
      it { is_expected.to eq 1000 }
    end

    context 'given split income' do
      let(:transaction) { build(:split_income, cents: 1000) }
      it { is_expected.to eq 1000 }
    end

    context 'given split expense' do
      let(:transaction) { build(:split_expense, cents: 1000) }
      it { is_expected.to eq(-1000) }
    end

    context 'given a transfer from' do
      let(:transaction) { build(:transfer_from, cents: 1000) }
      it { is_expected.to eq(-1000) }
    end

    context 'given a transfer to' do
      let(:transaction) { build(:transfer_to, cents: 1000) }
      it { is_expected.to eq 1000 }
    end
  end

  describe '#splittable?' do
    subject { transaction }

    context 'given an expense' do
      let(:transaction) { build(:expense) }
      it { is_expected.to be_splittable }
    end

    context 'given income' do
      let(:transaction) { build(:income) }
      it { is_expected.to be_splittable }
    end

    context 'given split income' do
      let(:transaction) { build(:split_income) }
      it { is_expected.to be_splittable }
    end

    context 'given split expense' do
      let(:transaction) { build(:split_expense) }
      it { is_expected.to be_splittable }
    end

    context 'given a transfer from' do
      let(:transaction) { build(:transfer_from) }
      it { is_expected.not_to be_splittable }
    end

    context 'given a transfer to' do
      let(:transaction) { build(:transfer_to) }
      it { is_expected.not_to be_splittable }
    end
  end

  describe '#split?' do
    subject { transaction }

    context 'given an expense' do
      let(:transaction) { build(:expense) }
      it { is_expected.not_to be_split }
    end

    context 'given income' do
      let(:transaction) { build(:income) }
      it { is_expected.not_to be_split }
    end

    context 'given split income' do
      let(:transaction) { build(:split_income) }
      it { is_expected.to be_split }
    end

    context 'given split expense' do
      let(:transaction) { build(:split_expense) }
      it { is_expected.to be_split }
    end

    context 'given a transfer from' do
      let(:transaction) { build(:transfer_from) }
      it { is_expected.not_to be_split }
    end

    context 'given a transfer to' do
      let(:transaction) { build(:transfer_to) }
      it { is_expected.not_to be_split }
    end
  end
end
