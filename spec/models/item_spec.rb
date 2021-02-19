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

  describe 'class methods' do
    before :each do
      @c1 = create(:customer)
      @m1 = create(:merchant)
      @m2 = create(:merchant)
      @m3 = create(:merchant)
      @i1 = create(:item, merchant: @m1, name: "bananas")
      @i2 = create(:item, merchant: @m2, description: "does this work")
      @i3 = create(:item, merchant: @m3)
      @in1 = create(:invoice, merchant: @m1, customer: @c1, status: "shipped")
      @in2 = create(:invoice, merchant: @m2, customer: @c1, status: "shipped")
      @in3 = create(:invoice, merchant: @m3, customer: @c1, status: "shipped")
      @t1 = create(:transaction, invoice: @in1, result: "success")
      @t2 = create(:transaction, invoice: @in2, result: "success")
      @t3 = create(:transaction, invoice: @in3, result: "success")
      5.times do
        create(:invoice_item, item: @i1, invoice: @in3, quantity: 4, unit_price: 5)
      end
      10.times do
        create(:invoice_item, item: @i3, invoice: @in1, quantity: 10, unit_price: 10)
      end
      3.times do 
        create(:invoice_item, item: @i2, invoice: @in2, quantity: 2, unit_price: 2)
      end
    end

    it 'top_revenue' do
      expect(Item.top_revenue(10)).to eq([@i3, @i1, @i2])
    end

    it 'item_search' do
      expect(Item.item_search("name", "ana")).to eq([@i1])
      expect(Item.item_search("description", "does")).to eq([@i2])

    end
  end
end