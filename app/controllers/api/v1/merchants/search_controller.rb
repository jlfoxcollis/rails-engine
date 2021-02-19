class Api::V1::Merchants::SearchController < ApplicationController
  def index
    current_uri = request.env['PATH_INFO']
    search = MerchantSearchFacade.search_merchants(params, current_uri)
    if search != nil
      render json: MerchantSerializer.new(search)
    else 
      render json: {"data" => {}}, status: 400
    end
  end
end