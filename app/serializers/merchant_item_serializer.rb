class MerchantItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :count

  # has_many :items

  # attribute :num_items do |object|
  #   object.items.count
  # end
end