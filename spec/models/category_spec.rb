# frozen_string_literal: true

describe Budget::Category do
  describe 'validations' do
    it 'can only be Income, Expense or Transfer when it is a root category' do
      expect(build(:category, parent: nil, name: 'Foo')).not_to be_valid
    end
  end

  describe '.budgeted' do
    subject { Budget::Category.budgeted }

    let!(:a) { create(:category, :budgeted) }
    let!(:b) { create(:category, :unbudgeted) }

    it { is_expected.to eq [a] }
  end

  describe '.unbudgeted' do
    subject { Budget::Category.unbudgeted }

    let!(:a) { create(:category, :budgeted) }
    let!(:b) { create(:category, :unbudgeted) }

    it { is_expected.to eq [b] }
  end

  describe '#destroy' do
    let!(:category) { create(:category) }

    context 'when there are related transactions' do
      let!(:txn) { create(:transaction, category: category) }

      it 'prevents deletion' do
        expect { category.destroy }.to raise_error ActiveRecord::DeleteRestrictionError
      end
    end

    context 'with no related transactions' do
      it 'allows deletion' do
        expect { category.destroy }.not_to raise_error
      end
    end
  end

  describe '#can_edit?' do
    subject { category.can_edit? }

    context 'given a normal category' do
      let(:category) { build(:category) }
      it { is_expected.to eq true }
    end

    context 'given a root category' do
      let(:category) { Budget::Category.expense }
      it { is_expected.to eq false }
    end

    context 'given a transfer category' do
      let(:category) { Budget::Category.transfer_from }
      it { is_expected.to eq false }
    end
  end

  describe '#can_destroy?' do
    subject { category.can_destroy? }

    context 'given a empty normal category' do
      let(:category) { build(:category) }
      it { is_expected.to eq true }
    end

    context 'given a category with associated transactions' do
      let!(:category) { create(:category) }
      let!(:txn) { create(:transaction, category: category) }

      it { is_expected.to eq false }
    end

    context 'given a root category' do
      let(:category) { Budget::Category.expense }
      it { is_expected.to eq false }
    end

    context 'given a transfer category' do
      let(:category) { Budget::Category.transfer_from }
      it { is_expected.to eq false }
    end
  end

  describe '#budgeted?' do
    subject { category.budgeted? }

    context 'given a category with budgeted_cents' do
      let(:category) { build(:category, :budgeted) }
      it { is_expected.to eq true }
    end

    context 'given a category with at 0.00 budget' do
      let(:category) { build(:category, budgeted_cents: 0) }
      it { is_expected.to eq false }
    end

    context 'given a category with a nil budget' do
      let(:category) { build(:category, budgeted_cents: nil) }
      it { is_expected.to eq false }
    end
  end

  describe '#transactions_count' do
    subject { category.transactions_count }

    let!(:category) { create(:category) }
    let!(:txn) { create(:transaction, category: category) }

    it { is_expected.to eq 1 }
  end

  %w(income expense transfers transfer_from transfer_to).each do |method_name|
    describe ".#{method_name}" do
      subject { Budget::Category.public_send(method_name) }

      it { is_expected.to be_an_instance_of Budget::Category }
      its(:name) { is_expected.to eq method_name.titleize }
    end
  end
end
