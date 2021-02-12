require 'rails_helper'

describe Item do
  describe 'relationships' do
    it {should belong_to :merchant }
    it {should have_many :invoice_items }
    it {should have_many(:invoices).through(:invoice_items)}
  end

  describe 'validations' do
    it {should validate_numericality_of :unit_price }
    it {should validate_presence_of :name }
    it {should validate_presence_of :description }
  end
end