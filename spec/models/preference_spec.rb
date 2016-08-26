# frozen_string_literal: true

describe Budget::Preference do
  describe 'validation' do
    it "requires it's key" do
      expect(build(:preference, key: nil)).not_to be_valid
    end

    it "requires it's value" do
      expect(build(:preference, value: nil)).not_to be_valid
    end

    it "requires it's owner" do
      expect(build(:preference, owner: nil)).not_to be_valid
    end
  end
end
