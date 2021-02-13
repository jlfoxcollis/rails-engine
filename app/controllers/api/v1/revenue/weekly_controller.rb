class Api::V1::Revenue::WeeklyController < ApplicationController

  def index
    weekly = WeeklyFacade.all_revenue(params)
    if weekly != nil
      render json: WeeklySerializer.new(weekly)
    else
      render json: {"data" => {}}, status: 404
    end
  end
end