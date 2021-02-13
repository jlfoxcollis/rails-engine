class WeeklyFacade 

  def self.all_revenue(params)
    weeks = (params[:quantity] || 52)
    Invoice.weekly_revenue(weeks)
  end
end