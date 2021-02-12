class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :invoices

  validates_presence_of :name


  def self.partial_search(find)
    key = "%#{find}%".downcase

    where("LOWER(name) like :search", search: key)
  end

end