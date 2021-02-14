require 'rails_helper'

describe 'revenue items API' do
  before :each do
    @c1 = create(:customer)
    @m1 = create(:merchant)
    @m2 = create(:merchant)
    @m3 = create(:merchant)
    @i1 = create(:item, merchant: @m1, name: "chocolate")
    @i2 = create(:item, merchant: @m2, name: "chocobot")
    @i3 = create(:item, merchant: @m3, name: "not related")
    @in1 = create(:invoice, merchant: @m1, customer: @c1, status: "shipped", created_at: Time.now + 1.weeks)
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

  it 'can get list of items by top revenue' do
    get "/api/v1/revenue/items?quantity=5"

    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)

    items = parsed[:data].each do |item|
      expect(item).to have_key(:attributes)
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)
      expect(item[:attributes]).to have_key(:revenue)
      expect(item[:attributes][:revenue]).to be_a(Float)
    end
  end

  it 'sad paths on empty quantity' do
    get "/api/v1/revenue/items?quantity="
    expect(response).to_not be_successful
  end
end