class ItemRevenueSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :description, :unit_price, :merchant_id

  attribute :revenue do |object|
    object.total_revenue.round(2)
  end
end