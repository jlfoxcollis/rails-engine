class MerchantSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name

  attribute :revenue, if: Proc.new {|object| object.respond_to? :revenue}
  attribute :count, if: Proc.new {|record| record.respond_to? :count }
end
