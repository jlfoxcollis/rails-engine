class Customer < ApplicationRecord
  validates_presence_of :first_name, :last_name

  has_many :invoices, dependent: :destroy
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items
  
end