require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  subject { build(:restaurant) }

  describe 'associations' do
    it { is_expected.to belong_to(:cuisine) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:distance) }
    it { is_expected.to validate_presence_of(:customer_rating) }
    it { is_expected.to validate_presence_of(:price) }
  end
end
