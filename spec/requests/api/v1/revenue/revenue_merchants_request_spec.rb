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

  it 'can return list of top revenue' do
    get "/api/v1/revenue/merchants?quantity=5"

    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed[:data]).to be_an(Array)
    parsed[:data].each do |merchant|
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes]).to have_key(:revenue)
      expect(merchant[:attributes][:revenue]).to be_a(Float)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  it 'can sad path on no quantity' do
    get "/api/v1/revenue/merchants"

    expect(response).to_not be_successful
  end

  it 'can get a merchant' do
    get "/api/v1/revenue/merchants/#{@m2.id}"

    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed[:data]).to have_key(:attributes)
    expect(parsed[:data][:attributes]).to have_key(:revenue)
    expect(parsed[:data][:attributes][:revenue]).to be_a(Float)
  end

  it 'can sad path for merchant' do
    get "/api/v1/revenue/merchants/#{999999}"

    expect(response).to_not be_successful
  end
end