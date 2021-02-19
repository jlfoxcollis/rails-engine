class ItemSearchFacade
  class << self

    def search_items(params, path)
      if path.include?("find_all")
        find_items(params)
      elsif path.include?("find") && !path.include?("all")
        find_one_item(params)
      end
    end

    def find_items(params)
      if params[:name].present? || params[:name] == ""
        params[:name] == "" ? [] : Item.partial_search(params[:name])
      elsif params[:min_price] || params[:max_price]
        min = (params[:min_price] || 0)
        max = (params[:max_price] || 999999)
        Item.price_check(min, max)
      end
    end

    def find_one_item(params)
      if params[:name].present?
        param = "name"
        Item.item_search(param, params[:name]).order(name: :asc).limit(1).first
      end
    end
  end
end