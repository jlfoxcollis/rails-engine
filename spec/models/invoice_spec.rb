require 'rails_helper'

describe Invoice do
  describe 'relationships' do
    it {should have_many :transactions }
    it {should have_many :invoice_items }
    it {should have_many(:items).through(:invoice_items)}
    it {should belong_to :merchant }
    it {should belong_to :customer }
  end

  describe 'validations' do
    it {should validate_presence_of :status }
  end

  describe 'class methods' do
    before :each do
      @c1 = create(:customer)
      @m1 = create(:merchant)
      @m2 = create(:merchant)
      @m3 = create(:merchant)
      @i1 = create(:item, merchant: @m1)
      @i2 = create(:item, merchant: @m2)
      @i3 = create(:item, merchant: @m3)
      @in1 = create(:invoice, merchant: @m1, customer: @c1, status: "shipped")
      @in2 = create(:invoice, merchant: @m2, customer: @c1, status: "shipped")
      @in3 = create(:invoice, merchant: @m3, customer: @c1, status: "packaged")
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

    it 'potential_revenue' do
      expect(Invoice.potential_revenue(20).first.potential_revenue).to eq(100)
    end

    it 'weekly_revenue' do
      expect(Invoice.weekly_revenue(5).first.revenue).to eq(1012.0)
    end
  end
end