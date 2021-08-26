class Restaurant < ApplicationRecord
    belongs_to :cuisine

    validates_presence_of :name, :distance, :customer_rating, :price
end
