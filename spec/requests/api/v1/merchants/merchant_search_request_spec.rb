require 'rails_helper'

describe 'Merchants API' do
  it 'sends a list of merchants' do
    create_list(:merchant, 10)
    Merchant.create(name: "willy Wonka")

    get "/api/v1/merchants/find?name=wil"

    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed).to have_key(:data)
    expect(parsed[:data]).to be_a(Hash)

    expect(parsed[:data]).to have_key(:id)
    expect(parsed[:data][:id]).to be_a(String)
    expect(parsed[:data]).to have_key(:attributes)
    expect(parsed[:data][:attributes]).to be_a(Hash)
    expect(parsed[:data][:attributes]).to have_key(:name)
    expect(parsed[:data][:attributes][:name]).to be_a(String)
  end

  it 'sad pathed on single merchant' do
    create_list(:merchant, 10)
    Merchant.create(name: "willy Wonka")

    get "/api/v1/merchants/find?name=123"

    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed).to have_key(:data)
    expect(parsed[:data]).to be_a(Hash)
    expect(parsed[:data].keys.count).to eq(0)
  end

  it 'can find all merchants' do
    create_list(:merchant, 10)
    Merchant.create(name: "Willy Nillster")
    Merchant.create(name: "willy Wonka")

    get "/api/v1/merchants/find_all?name=wiL"

    expect(response).to be_successful

    parsed = JSON.parse()
  end
end