class Api::V1::Revenue::UnshippedController < ApplicationController

  def index
    unshipped = UnshippedFacade.calculate_unshipped(params)
    if unshipped != nil
      render json: UnshippedSerializer.new(unshipped)
    else
      render json: {"error" => {}}, status: 400
    end
  end
end