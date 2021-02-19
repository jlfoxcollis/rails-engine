class Api::V1::Revenue::UnshippedController < ApplicationController
  def index
    begin
      unshipped = UnshippedFacade.calculate_unshipped(params)
      render json: UnshippedSerializer.new(unshipped)
    rescue
      render json: {"error" => {}}, status: 400
    end
  end
end