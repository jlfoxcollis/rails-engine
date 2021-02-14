require 'rails_helper'

describe Merchant do
  describe 'relationships' do
    it {should have_many :items }
    it {should have_many :invoices }
    it {should have_many(:transactions).through(:invoices) }
    it {should have_many(:customers).through(:invoices) }
    it {should have_many(:invoice_items).through(:items) }
  end

  describe 'validations' do
    it {should validate_presence_of :name }
  end

  describe 'instance methods' do
    it 'can find all, partials, case insensitive' do
      create_list(:merchant, 10)
      m1 = Merchant.create(name: "Willy Nillster")
      m2 = Merchant.create(name: "WILLY Wonka")

      expect(Merchant.partial_search("ilLy")).to eq([m1, m2])
    end
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
      expect(Merchant.top_revenue(20)).to eq([@m1, @m3, @m2])
    end

    it 'most_items_sold' do
      expect(Merchant.most_items_sold(20)).to eq([@m1, @m3, @m2])
    end

    it 'revenue_by_range' do
      start_date = Time.now - 1.days
      end_date = Time.now + 1.days
      expect(Merchant.revenue_by_range(start_date, end_date)).to eq(1112.0)
    end
  end
end