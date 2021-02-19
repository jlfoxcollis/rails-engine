class RevenueFacade
  class << self
    def date_range(params)
      start_date = params[:start].to_date
      end_date = params[:end].to_date + 1.days
      Merchant.revenue_by_range(start_date, end_date)
    end
  end
end
