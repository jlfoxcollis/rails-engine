class Api::V1::Items::SearchController < ApplicationController

  def index
    current_uri = request.env['PATH_INFO']
    search = ItemSearchFacade.search_items(params, current_uri)
    if search != nil
      render json: ItemSerializer.new(search)
    else 
      render json: {"data" => {}}, status: 400
    end
  end
end