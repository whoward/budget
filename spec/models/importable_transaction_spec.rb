# frozen_string_literal: true
require 'rails_helper'

describe Budget::ImportableTransaction do
  describe 'validations' do
    it 'requires its account' do
      expect(build(:importable_transaction, importable_account: nil)).not_to be_valid
    end

    it 'requires a date' do
      expect(build(:importable_transaction, date: nil)).not_to be_valid
    end

    it 'requires valid cents' do
      expect(build(:importable_transaction, cents: nil)).not_to be_valid
      expect(build(:importable_transaction, cents: -500)).not_to be_valid
    end
  end
end
