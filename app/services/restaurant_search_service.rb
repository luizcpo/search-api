class RestaurantSearchService < ApplicationService
  # the list of criteria in order of importance as described in the assessment
  POSSIBLE_PARAMS = [:name, :distance, :customer_rating, :price, :cuisine]
  SORT_CRITERIA_LIST = %w(distance customer_rating price)

  def initialize(params)
    @name = params[:name]
    @customer_rating = params[:customer_rating]
    @distance = params[:distance]
    @price = params[:price]
    @cuisine = params[:cuisine]
  end

  def search
    restaurants = Restaurant.all.includes(:cuisine).to_a

    restaurants.select! { |r| r.name.include? @name } if @name
    restaurants.select! { |r| r.customer_rating >= @customer_rating } if @customer_rating
    restaurants.select! { |r| r.distance <= @distance } if @distance
    restaurants.select! { |r| r.price <= @price } if @price
    restaurants.select! { |r| r.cuisine.name.include? @cuisine } if @cuisine

    return [] if restaurants.empty?

    restaurants.sort_by! { |r| r[:distance] }

    # As we have the array sorted, we get the first 30 registers
    # to improve performance
    restaurants = sort_by_next_criteria(restaurants[0..29], 0)
    restaurants = sort_by_next_criteria(restaurants, 1)

    restaurants[0..4]
  end

  # Sorting the list of restaurants that have equal matches
  def sort_by_next_criteria(restaurants, attr_index)
    prev_attr = SORT_CRITERIA_LIST[attr_index-1] if attr_index-1 >= 0
    attribute = SORT_CRITERIA_LIST[attr_index]
    next_attr = SORT_CRITERIA_LIST[attr_index+1]

    char = "A"
    key = mount_key(restaurants[0], prev_attr, attribute, char)
    
    restaurants_matrix = {}
    restaurants_matrix[key] = []
    restaurants_sorted = []

    restaurants.each do |restaurant|
      compare_key = mount_key(restaurant, prev_attr, attribute, char)
      
      if compare_key == key
        restaurants_matrix[key].append(restaurant)
      else
        restaurants_matrix[key].sort_by! { |r| r[next_attr] }
        restaurants_matrix[key].reverse! if next_attr == 'customer_rating'

        char.next!
        key = mount_key(restaurant, prev_attr, attribute, char)
        
        restaurants_matrix[key] = []
        restaurants_matrix[key].append(restaurant)
      end
    end
    
    restaurants_matrix.values.to_a.flatten
  end

  # Mount the key to define what criteria is equal to bundle them together
  def mount_key(restaurant, prev_attr, attribute, char)
    char+restaurant[attribute].to_s
  end
end