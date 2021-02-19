class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  
  validates_presence_of :name
  validates_presence_of :description
  validates :unit_price, presence: true, format: { with: /\A\d{0,11}(\.?\d{0,2})?\z/ }, numericality: true

  def self.top_revenue(quantity)
    joins(invoices: :transactions)
    .select('items.*, sum(invoice_items.quantity * invoice_items.unit_price) AS total_revenue')
    .where('transactions.result = ? AND invoices.status = ?', "success", "shipped")
    .group(:id).limit(quantity).order('total_revenue DESC')
  end

  def self.item_search(attr, partial)
    key = "%#{partial}%"
    title = arel_table["#{attr}"]
    where(title.matches(key))
  end


  def self.price_check(min, max)
    where('items.unit_price >= ? AND items.unit_price <= ?', min, max)
  end
end