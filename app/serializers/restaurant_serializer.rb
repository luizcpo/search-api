# frozen_string_literal: true

class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name, :customer_rating, :distance, :price, :cuisine

  def cuisine
    object.cuisine.name    
  end
end
  