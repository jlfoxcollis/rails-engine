class Api::V1::RevenueController < ApplicationController

  def index
    if params[:start].present? && params[:end].present?
      revenue = RevenueFacade.date_range(params)
      render json: {"data" => {"type" => "revenue", "id" => nil, "attributes" => {"revenue" => revenue}}}
    else
      render json: {"error" => {}}, status: 400
    end
  end
end