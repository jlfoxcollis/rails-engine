class RevenueItemsFacade
  class << self

    def top_revenue(params)
      page = (params[:page] || 1).to_i
      per_page = (params[:per_page] || 10).to_i
      quantity = (params[:quantity] || 10).to_i
      Item.top_revenue(quantity).offset((page * 20) - 20)
    end
  end
end