class Api::V1::Items::SearchController < ApplicationController

  def index
    current_uri = request.env['PATH_INFO']
    search = ItemSearchFacade.search_items(params, current_uri)
    if search.class == String
      render json: {"error" => search}, status: 404
    elsif search != []
      render json: ItemSerializer.new(search)
    else 
      render json: {"data" => {}}
    end
  end
end