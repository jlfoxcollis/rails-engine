class MerchantRevenueSerializer
  include FastJsonapi::ObjectSerializer
  attributes :revenue

  # has_many :items

  # attribute :num_items do |object|
  #   object.items.count
  # end
end