class UnshippedFacade 

  def self.calculate_unshipped(params)
    quantity = (params[:quantity] || 10)
    Invoice.potential_revenue(quantity)
  end

end