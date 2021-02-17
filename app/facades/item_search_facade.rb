class ItemSearchFacade
  class << self

    def search_items(params, path)
      if params[:name] && (params[:min_price] || params[:max_price])
        "Can't include both name and price search params"
      elsif path.include?("find_all")
        find_items(params)
      elsif path.include?("find") && !path.include?("all")
        find_items(params).limit(1).first
      end
    end

    def find_items(params)
      if params[:name]
        params[:name] == "" ? "Name cant be blank" : Item.partial_search(params[:name])
      elsif params[:min_price] || params[:max_price]
        min = (params[:min_price] || 0)
        max = (params[:max_price] || 999999)
        Item.price_check(min, max)
      end
    end
  end
end