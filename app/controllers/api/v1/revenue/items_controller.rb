class Api::V1::Revenue::ItemsController < ApplicationController

  def index
    current_uri = request.env['PATH_INFO']
    if params[:quantity]
    items = RevenueItemsFacade.top_revenue(params)
      render json: ItemRevenueSerializer.new(items)
    else 
      render json: {"error" => {}}, status: 400
    end
  end
end