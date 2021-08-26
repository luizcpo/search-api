class RestaurantsController < ApplicationController
  before_action :sanitize_params

  def index
    service = RestaurantSearchService.new(params)

    render json: service.search, 
           each_serializer: RestaurantSerializer,
           status: :ok
  end

  private

  def sanitize_params
    params[:customer_rating] = params[:customer_rating]&.to_i
    params[:distance] = params[:distance]&.to_i
    params[:price] = params[:price]&.to_i
  end
end
