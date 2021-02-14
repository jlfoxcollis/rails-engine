class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :transactions, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items

  validates_presence_of :status
  class << self
    def potential_revenue(quantity)
      joins(:invoice_items, :transactions)
        .select('invoices.*, sum(invoice_items.quantity * invoice_items.unit_price) as potential_revenue')
        .where('invoices.status <> ? AND transactions.result = ?', "shipped", "success")
        .group(:id)
        .limit(quantity)
        .order('potential_revenue DESC')
    end

    def weekly_revenue(params)
      joins(:invoice_items, :transactions)
      .select("date_trunc('week', invoices.updated_at::date) AS week, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue")
      .where('transactions.result = ? AND invoices.status = ?', "success", "shipped")
      .group('week')
      .order('week')
      .limit(params)
    end
  end
end