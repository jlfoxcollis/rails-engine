require 'rails_helper'

describe 'revenue API' do
  before :each do
    @c1 = create(:customer)
    @m1 = create(:merchant)
    @m2 = create(:merchant)
    @m3 = create(:merchant)
    @i1 = create(:item, merchant: @m1)
    @i2 = create(:item, merchant: @m2)
    @i3 = create(:item, merchant: @m3)
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

  it 'can return all revenue for a date range' do
    start_time = Time.now - 1.days
    end_time = Time.now + 1.days
    get "/api/v1/revenue?start=#{start_time}&end=#{end_time}"

    expect(response).to be_successful

    revenue = JSON.parse(response.body, symbolize_names: true)

    expect(revenue[:data]).to be_a(Hash)
    expect(revenue[:data][:attributes][:revenue]).to be_an(Float)
  end

  it 'can return all revenue for a date range' do
    start_time = Time.now - 1.days
    get "/api/v1/revenue?start=#{start_time}"

    expect(response).to_not be_successful

    revenue = JSON.parse(response.body, symbolize_names: true)

    expect(revenue[:error]).to be_a(Hash)
  end
end

