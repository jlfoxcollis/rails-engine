class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  validates_presence_of :quantity, numericality: true
  validates :unit_price, presence: true, format: { with: /\A\d{0,11}(\.?\d{0,2})?\z/ }, numericality: true
end