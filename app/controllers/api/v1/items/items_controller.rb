class Api::V1::Items::ItemsController < ApplicationController

  def index
    page = (params[:page] || 1).to_i
    per_page = (params[:per_page] || 20).to_i
    items = Item.limit(per_page).offset((page * 20) - 20)
    render json: ItemSerializer.new(items)
  end

  def create
    item = Item.new(item_params)
    if item.save
      render json: ItemSerializer.new(item), status: :created
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