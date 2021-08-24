class RestaurantsController < ApplicationController
  def index
    render json: 'Mensagem de teste'.to_json
  end

  def sanitize_params
    params.require(:user_id)
    params[:user_id] = params[:user_id]&.to_i
    params[:page] = params[:page]&.to_i
    params[:department_id] = params[:department_id]&.map(&:to_i)
  end
end
