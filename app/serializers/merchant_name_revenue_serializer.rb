class MerchantNameRevenueSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :revenue

  # has_many :items

  # attribute :num_items do |object|
  #   object.items.count
  # end
end