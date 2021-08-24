require 'csv'

CUISINE_DATA = CSV.parse(File.read('db/cuisines.csv'))
RESTAURANTS_DATA = CSV.parse(File.read('db/restaurants.csv'))

CUISINES = CUISINE_DATA.each.with_object({}) do |cuisine, memo| 
  cuisine_name = cuisine[1]
  cuisine_id = cuisine[0]
  memo[cuisine_id] = Cuisine.create!(name: cuisine_name)
end

RESTAURANTS_DATA.each do |restaurant|
  Restaurant.create!(
    name: restaurant[0],
    customer_rating: restaurant[1],
    distance: restaurant[2],
    price: restaurant[3],
    cuisine: CUISINES[restaurant[4]]
  )
end
