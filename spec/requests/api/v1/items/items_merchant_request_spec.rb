require 'rails_helper'

describe 'items merchant API' do
  it 'can fetch an items merchant' do
    merchant = create(:merchant)
    item = create(:item, merchant: merchant)

    get "/api/v1/items/#{item.id}/merchant"

    expect(response).to be_successful

    items_merchant = JSON.parse(response.body, symbolize_names: true)

    expect(items_merchant).to have_key(:data)
    expect(items_merchant[:data]).to be_a(Hash)
    expect(items_merchant[:data]).to have_key(:attributes)
    expect(items_merchant[:data][:attributes]).to be_a(Hash)
    expect(items_merchant[:data][:attributes]).to have_key(:name)
    expect(items_merchant[:data][:attributes][:name]).to be_a(String)
  end
end