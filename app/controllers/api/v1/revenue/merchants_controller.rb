class Api::V1::Revenue::MerchantsController < ApplicationController

  def index
    current_uri = request.env['PATH_INFO']
    if params[:quantity] != nil
      merchants = RevenueMerchantsFacade.top_revenue(params)
      render json: MerchantNameRevenueSerializer.new(merchants)
    else 
      render json: {"error" => {}}, status: 400
    end
  end

  def show
    begin
      merchant = Merchant.top_revenue(1).find(params[:id])
      render json: MerchantRevenueSerializer.new(merchant)
    rescue
      render json: {"error" => {}}, status: 404
    end
  end

end