# frozen_string_literal: true

describe Budget::ImportService do
  describe 'validation' do
    it 'requires a valid type' do
      expect(build(:import_service, type: 'Account')).not_to be_valid
    end
  end
end
