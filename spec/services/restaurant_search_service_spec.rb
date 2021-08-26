# frozen_string_literal: true

require 'rails_helper'

describe RestaurantSearchService, type: :service do
  subject { described_class.new({}) }
  
  describe '#search' do
    it 'should return 5 restaurants' do
      create_list(:restaurant, 10)
      
      expect(subject.search.size).to eq(5)
    end

    it 'should return 3 restaurants with "Chow" in the name' do
      subject { described_class.new({:name => "Chow"}) }

      create_list(:restaurant, 3, :with_chow_in_the_name)

      expect(subject.search.size).to eq(3)
    end
  end
end
