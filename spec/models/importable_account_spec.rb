require 'rails_helper'

describe Budget::ImportableAccount do
  describe 'validations' do
    it 'requires a valid name' do
      expect(build(:importable_account, name: nil)).not_to be_valid
    end
  end
end
