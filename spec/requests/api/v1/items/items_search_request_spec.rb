require 'rails_helper'

describe 'items search API' do
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

  it 'sends an item' do

    get "/api/v1/items/find?name=rel"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data]).to have_key(:attributes)
    expect(item[:data][:attributes]).to have_key(:name)
    expect(item[:data][:attributes][:name]).to eq("not related")
  end

  it 'sad path on search' do

    get "/api/v1/items/find?name=toonies"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)
  end

  it 'sends a item list' do
    get "/api/v1/items/find_all?name=choco"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    items[:data].each do |item|

      expect(item[:attributes]).to be_a(Hash)
      expect(item[:attributes]).to have_key(:name)
    end
  end
  
end