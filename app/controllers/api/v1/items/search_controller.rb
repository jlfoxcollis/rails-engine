class Api::V1::Items::SearchController < ApplicationController
  def index
    current_uri = request.env['PATH_INFO']
    if params[:name] && (params[:min_price] || params[:max_price])
      render json: {"data" => {"error" => "Can't include both name and price search params"}}, status: 404
    else
      search = ItemSearchFacade.search_items(params, current_uri)
      if search != nil
        render json: ItemSerializer.new(search)
      else 
        render json: {"data" => {}}, status: 400
      end
    end
  end
end