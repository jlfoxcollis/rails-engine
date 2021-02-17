class Api::V1::Merchants::MerchantsController < ApplicationController

  def index
    merchants = Merchant.paginate(params[:per_page], params[:page])
    render json: MerchantSerializer.new(merchants)
  end

  def show
    render json:  MerchantSerializer.new(Merchant.find(params[:id]))
  end

end