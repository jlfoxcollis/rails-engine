class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :transactions, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items

  validates_presence_of :status

  def self.potential_revenue(quantity)
    joins(:invoice_items, :transactions)
      .select('invoices.*, sum(invoice_items.quantity * invoice_items.unit_price) as potential_revenue')
      .where('invoices.status <> ? AND transactions.result = ?', "shipped", "success")
      .group(:id)
      .limit(quantity)
      .order('potential_revenue DESC')
  end

end