class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :items

  validates_presence_of :name


  def self.top_revenue(params)
    Merchant.joins(invoices: [:invoice_items, :transactions])
    .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    .where('invoices.status = ? AND transactions.result = ?', "shipped", "success")
    .limit(params)
    .order('revenue desc')
    .group(:id)
  end

  def self.most_items_sold(params)
    Merchant.joins(invoices: [:invoice_items, :transactions])
    .select('merchants.*, sum(invoice_items.quantity) AS count')
    .where('invoices.status = ? AND transactions.result = ?', "shipped", "success")
    .limit(params)
    .order('count desc')
    .group(:id)
  end

  def self.revenue_by_range(start_date, end_date)
    joins(invoices: [:invoice_items, :transactions])
    .where('transactions.result = ? AND invoices.status = ? AND invoices.created_at >= ? AND invoices.created_at < ?', "success", "shipped", start_date, end_date)
    .sum('invoice_items.quantity * invoice_items.unit_price').round(2)
  end
end