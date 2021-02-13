class RevenueMerchantsFacade
  class << self

    def top_revenue(params)
      page = (params[:page] || 1).to_i
      per_page = (params[:per_page] || 20).to_i
      Merchant.top_revenue(params[:quantity]).offset((page * 20) - 20)
    end
  end
end