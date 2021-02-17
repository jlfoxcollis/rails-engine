class Api::V1::Merchants::MostItemsController < ApplicationController
  def index
    current_uri = request.env['PATH_INFO']
    search = MerchantSearchFacade.search_merchants(params, current_uri)
    if search != nil
      render json: MerchantSerializer.new(search)
    else 
      render json: {"error" => {}}, status: 400
    end
  end

end