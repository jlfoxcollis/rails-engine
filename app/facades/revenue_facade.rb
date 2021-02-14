class RevenueFacade

  def self.date_range(params)
    start_date = params[:start].to_time
    end_date = params[:end].to_time
    invoice = Invoice.revenue_by_range(start_date, end_date)
  end
end
