require 'rails_helper'

describe 'items search API' do
  before :each do
    @c1 = create(:customer)
    @m1 = create(:merchant)
    @m2 = create(:merchant)
    @m3 = create(:merchant)
    @i1 = create(:item, merchant: @m1, name: "chocolate", unit_price: 5)
    @i2 = create(:item, merchant: @m2, name: "chocobot", unit_price: 2)
    @i3 = create(:item, merchant: @m3, name: "not related", unit_price: 10)
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

    expect(response).to_not be_successful
    parsed = JSON.parse(response.body, symbolize_names: true)
    expect(parsed).to have_key(:data)
    expect(parsed[:data]).to be_a(Hash)
    expect(parsed[:data].keys.count).to eq(0)

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

  it 'returns empty array if search returns nothing' do
    get "/api/v1/items/find_all?name=HippoStrikefulcantfindthisname"

    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)
    
    expect(parsed[:data]).to be_an(Array)
    expect(parsed[:data]).to eq([])
  end

  it 'can search by price' do
    get "/api/v1/items/find_all?min_price=2&max_price=7"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items).to have_key(:data)
    
    items[:data].each do |item|

      expect(item).to have_key(:attributes)
    end
    expect(items[:data].first[:attributes][:name]).to eq(@i1.name)
  end

  it 'can search by price' do
    get "/api/v1/items/find_all?min_price=7"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items).to have_key(:data)
    expect(items[:data].first[:attributes][:name]).to eq(@i3.name)
  end

  it 'cant search by price and name' do
    get "/api/v1/items/find_all?min_price=7&name=bob"

    expect(response).to_not be_successful

    items = JSON.parse(response.body, symbolize_names: true)
    expect(items).to have_key(:data)
    expect(items[:data]).to be_a(Hash)
    expect(items[:data]).to have_key(:error)
    expect(items[:data][:error]).to be_a(String)
    expect(items[:data][:error]).to eq("Can't include both name and price search params")
  end
end