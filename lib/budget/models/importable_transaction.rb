
module Budget
  class ImportableTransaction < ActiveRecord::Base
    belongs_to :importable_account, class_name: 'Budget::ImportableAccount',
                                    foreign_key: 'account_id',
                                    primary_key: 'source_id'

    scope :imported, -> { where('imported_id is not null') }
    scope :not_imported, -> { where(imported_id: nil) }

    scope :expense, -> { where(expense: true) }
    scope :income, -> { where(expense: false) }

    validates :importable_account, presence: true

    validates :date, presence: true

    validates :cents, presence: true, numericality: { greater_than_or_equal_to: 0 }

    def signed_cents
      expense ? -cents : cents
    end
  end
end
