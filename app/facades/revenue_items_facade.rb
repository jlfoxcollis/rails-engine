class RevenueItemsFacade
  class << self

    def top_revenue(params)
      quantity = (params[:quantity] || 10).to_i
      items = Item.top_revenue(quantity)
    end
  end
end