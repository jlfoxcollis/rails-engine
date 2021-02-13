class MerchantSearchFacade
  class << self

    def search_merchants(params, path)
      if path.include?("find_all")
        find_all_merchants(params)
      elsif path.include?("find") && !path.include?("all")
        find_one_merchant(params)
      elsif path.include?("most_items")
        merchants_with_top_items_sold(params)
      end
    end

    def find_all_merchants(params)
      if params[:name].present? || params[:name] == ""
        params[:name] == "" ? [] : Merchant.partial_search(params[:name])
      end
    end

    def find_one_merchant(params)
      if params[:name].present?
        Merchant.partial_search(params[:name]).order(name: :asc).limit(1).first
      end
    end

    def merchants_with_top_items_sold(params)
      if params[:quantity].present?
        params[:quantity] == "" ? [] : Merchant.most_items_sold(params[:quantity])
      end
    end
  end
end