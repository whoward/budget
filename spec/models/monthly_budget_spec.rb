# frozen_string_literal: true

describe Budget::MonthlyBudget, database_cleaning_strategy: :truncation do
  subject { described_class.new(2000, 1) }

  describe '#each' do
    subject { super().to_a }

    context 'when there is a budgeted category in the database' do
      let!(:category) { create(:category, budgeted_cents: 100_000) }

      it { is_expected.to eq [[category.id, 100_000]] }
    end
  end
end
