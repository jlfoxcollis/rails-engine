class Api::V1::Items::ItemsController < ApplicationController

  def index
    items = Item.paginate(params[:per_page], params[:page])
    render json: ItemSerializer.new(items)
  end

  def create
    begin
      item = Item.new(item_params)
      item.save
      render json: ItemSerializer.new(item), status: :created
    rescue => error
      render json: {"error" => error.message}
    end 
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      render json: ItemSerializer.new(item)
    else
      render json: item, :status => 404
    end
  end

  def destroy
    render json: Item.delete(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end