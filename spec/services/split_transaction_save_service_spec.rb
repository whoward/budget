# frozen_string_literal: true

describe Budget::Service::SplitTransactionSave do
  describe '#validate' do
    it 'is true given valid arguments' do
      txn = build(:expense, cents: 100_00)
      a = build(:expense, cents: 25_00)
      b = build(:expense, cents: 75_00)

      result = described_class.new(transaction: txn, partitions: [a, b]).validate

      expect(result).to eq true
    end

    it "is :sum_of_parts_doesnt_equal_total if the part's cents don't equal the transaction total" do
      txn = build(:expense, cents: 100_00)
      a = build(:expense, cents: 1_00)
      b = build(:expense, cents: 1_00)

      result = described_class.new(transaction: txn, partitions: [a, b]).validate

      expect(result).to eq :sum_of_parts_doesnt_equal_total
    end

    it 'is :partitions_inconsistent_type if the transaction is an expense and there are income parts' do
      txn = build(:expense, cents: 100_00)
      a = build(:expense, cents: 25_00)
      b = build(:income, cents: 75_00)

      result = described_class.new(transaction: txn, partitions: [a, b]).validate

      expect(result).to eq :partitions_inconsistent_type
    end

    it 'is :partitions_inconsistent_type if the transaction is income and there are expense parts' do
      txn = build(:income, cents: 100_00)
      a = build(:expense, cents: 25_00)
      b = build(:income, cents: 75_00)

      result = described_class.new(transaction: txn, partitions: [a, b]).validate

      expect(result).to eq :partitions_inconsistent_type
    end

    [Budget::TransferFrom, Budget::TransferTo, Budget::Transaction].each do |invalid_class|
      it "is :transaction_must_be_income_or_expense if the transction is a #{invalid_class.name}" do
        txn = build(invalid_class.name.demodulize.underscore, cents: 100_00)

        part_type = txn.is_a?(Budget::Expense) ? :expense : :income

        a = build(part_type, cents: 25_00)
        b = build(part_type, cents: 75_00)

        result = described_class.new(transaction: txn, partitions: [a, b]).validate

        expect(result).to eq :transaction_must_be_income_or_expense
      end
    end
  end

  describe '#call' do
    it 'turns the given transaction into a SplitTransaction and saves the associated parts' do
      txn = build(:expense, cents: 100_00)
      a = build(:expense, cents: 25_00)
      b = build(:expense, cents: 75_00)

      result = described_class.new(transaction: txn, partitions: [a, b]).call

      expect(result).to be_success

      transformed = Budget::Transaction.find(txn.id) # reload is not enough

      expect(transformed).to be_an_instance_of Budget::SplitExpenseTransaction
      expect(a.split_transaction).to eq transformed
      expect(b.split_transaction).to eq transformed
    end

    it 'returns a failing validation result as a service object' do
      txn = build(:expense, cents: 100_00)
      a = build(:expense, cents: 1_00)
      b = build(:expense, cents: 1_00)

      result = described_class.new(transaction: txn, partitions: [a, b]).call

      expect(result).to be_failure
      expect(result.reason).to eq :sum_of_parts_doesnt_equal_total
    end

    it 'removes existing partitions if the transaction already has them' do
      txn = build(:expense, cents: 100_00)
      a = build(:expense, cents: 25_00)
      b = build(:expense, cents: 75_00)

      described_class.new(transaction: txn, partitions: [a, b]).call

      txn = Budget::Transaction.find(txn.id) # reload is not enough

      c = build(:expense, cents: 30_00)
      d = build(:expense, cents: 70_00)

      result = described_class.new(transaction: txn, partitions: [c, d]).call

      expect(result).to be_success

      expect { a.reload }.to raise_error ActiveRecord::RecordNotFound
      expect { b.reload }.to raise_error ActiveRecord::RecordNotFound

      txn = Budget::Transaction.find(txn.id) # reload is not enough

      expect(txn).to be_an_instance_of Budget::SplitExpenseTransaction
      expect(txn.partitions).to match_array [c, d]
      expect(c.split_transaction).to eq txn
      expect(d.split_transaction).to eq txn
    end
  end
end
