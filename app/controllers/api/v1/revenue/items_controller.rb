class Api::V1::Revenue::ItemsController < ApplicationController

  def index
    current_uri = request.env['PATH_INFO']
    if params[:quantity] != nil
      merchants = RevenueMerchantsFacade.top_revenue(params)
      render json: MerchantNameRevenueSerializer.new(merchants)
    else 
      render json: {"error" => {}}, status: 400
    end
  end

end