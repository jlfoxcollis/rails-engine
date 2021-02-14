require 'rails_helper'

describe 'revenue unshipped API' do
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
    @in3 = create(:invoice, merchant: @m3, customer: @c1, status: "unshipped")
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

  it 'can calculate unshipped revenue' do

    get "/api/v1/revenue/unshipped"

    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)
    expect(parsed[:data].first[:attributes]).to have_key(:potential_revenue)
    expect(parsed[:data].first[:attributes][:potential_revenue]).to be_a(Float)
  end

  it 'can sad path if quantity is blank' do
    get "/api/v1/revenue/unshipped?quantity=abc"

    expect(response).to_not be_successful
  end
end