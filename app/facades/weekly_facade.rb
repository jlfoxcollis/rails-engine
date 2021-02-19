class WeeklyFacade 
  class << self
    def all_revenue(params)
      weeks = (params[:quantity] || 52)
      Invoice.weekly_revenue(weeks)
    end
  end
end