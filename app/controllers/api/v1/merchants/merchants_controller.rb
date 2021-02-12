class Api::V1::Merchants::MerchantsController < ApplicationController
  MERCHANTS_SIZE = 20

  def index
    page = (params[:page] || 1).to_i
    per_page = (params[:per_page] || 20).to_i
    merchants = Merchant.limit(per_page).offset((page * 20) - 20)
    render json: MerchantSerializer.new(merchants)
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end

end