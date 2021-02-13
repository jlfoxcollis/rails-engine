class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  
  validates_presence_of :name
  validates_presence_of :description
  validates :unit_price, presence: true, format: { with: /\A\d{0,11}(\.?\d{0,2})?\z/ }, numericality: true


  def self.top_revenue(quantity)
    joins(invoices: [:invoice_items, :transactions]).select('items.*, sum(invoice_items.quantity * items.unit_price) AS revenue').where('transactions.result = ? AND invoices.status = ?', "success", ).group(:id).limit(quantity).order('revenue desc')
  end
end