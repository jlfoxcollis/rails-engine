class MerchantSearchFacade
  class << self

    def search_merchants(params, path)
      if path.include?("find_all")
        find_all_merchants(params)
      elsif path.include?("find") && !path.include?("all")
        find_one_merchant(params)
      end
    end

    def find_all_merchants(params)
      if params[:name].present?
        Merchant.partial_search(params[:name])
      end
    end

    def find_one_merchant(params)
      if params[:name].present?
        Merchant.partial_search(params[:name]).order(name: :asc).limit(1).first
      end
    end
  end
end