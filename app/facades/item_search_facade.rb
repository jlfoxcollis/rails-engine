class ItemSearchFacade
  class << self

    def search_items(params, path)
      if path.include?("find_all")
        find_all_items(params)
      elsif path.include?("find") && !path.include?("all")
        find_one_item(params)
      end
    end

    def find_all_items(params)
      if params[:name].present? || params[:name] == ""
        params[:name] == "" ? [] : Item.partial_search(params[:name])
      end
    end

    def find_one_item(params)
      if params[:name].present?
        Item.partial_search(params[:name]).order(name: :asc).limit(1).first
      end
    end
  end
end