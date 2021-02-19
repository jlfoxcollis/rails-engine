class Api::V1::Revenue::WeeklyController < ApplicationController
  def index
    begin
      weekly = WeeklyFacade.all_revenue(params)
      render json: WeeklySerializer.new(weekly)
    rescue
      render json: {"data" => {}}, status: 404
    end
  end
end