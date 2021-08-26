require 'rails_helper'

RSpec.describe Cuisine, type: :model do
  subject { build(:cuisine) }

  describe 'associations' do
    it { is_expected.to have_many(:restaurants) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
