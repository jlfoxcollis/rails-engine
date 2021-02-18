require 'rails_helper'

describe 'items API' do
  it 'sends a list of all, max 20 items' do
    merchant = create(:merchant)

    30.times do
      create(:item, merchant: merchant)
    end

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].length).to eq(20)
    expect(items).to have_key(:data)
    expect(items[:data]).to be_an(Array)
    items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)
      expect(item).to have_key(:attributes)
      expect(item[:attributes]).to be_a(Hash)
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)
      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)
      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)
    end
  end

  it 'sends 1 item' do
    merchant = create(:merchant)
    id = create(:item, merchant: merchant).id

    get "/api/v1/items/#{id}"

    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)
    expect(parsed).to have_key(:data)
    expect(parsed[:data]).to be_a(Hash)

    item = parsed[:data]

    expect(item).to have_key(:id)
    expect(item[:id]).to be_a(String)
    expect(item).to have_key(:attributes)
    expect(item[:attributes]).to be_a(Hash)
    expect(item[:attributes]).to have_key(:name)
    expect(item[:attributes][:name]).to be_a(String)
    expect(item[:attributes]).to have_key(:description)
    expect(item[:attributes][:description]).to be_a(String)
    expect(item[:attributes]).to have_key(:unit_price)
    expect(item[:attributes][:unit_price]).to be_a(Float)
  end

  it 'can create an item' do
    merchant = create(:merchant)
    item_params = ({
      name: "Shampoo",
      description: "It goes on the head",
      unit_price: 23.55,
      merchant_id: merchant.id
    })

    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params, merchant_id: merchant.id)
    created_item = Item.last

    expect(response).to be_successful
    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price])
    expect(created_item.merchant).to eq(merchant)
  end

  it 'can sad path not create an item' do
    headers = {"CONTENT_TYPE" => "application/json"}
    post "/api/v1/items?name=Shampoo&description=ShouldFail&unit_price=23.55", headers: headers
    expect(response).to be_successful
    parsed = JSON.parse(response.body, symbolize_names: true)
    expect(parsed).to have_key(:error)
    expect(parsed[:error]).to be_a(String)
    expect(parsed[:error]).to eq("param is missing or the value is empty: item")
  end

  it 'can update an item' do
    merchant = create(:merchant)
    item = create(:item, merchant: merchant)
    item_name = item.name
    item_params = {name: "updating the name"}
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{item.id}", headers: headers, params: JSON.generate(item: item_params)
    updated = Item.find(item.id)
    expect(response).to be_successful
    expect(updated.name).to_not eq(item_name)
    expect(updated.name).to eq(item_params[:name])
  end

  it 'sad path 404 error on update' do
    merchant = create(:merchant)
    item = create(:item, merchant: merchant)
    item_params = {merchant_id: 9999999999}
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{item.id}", headers: headers, params: JSON.generate(item: item_params)
    expect(response).to_not be_successful
  end


  it 'can delete an item' do
    merchant = create(:merchant)
    item = create(:item, merchant: merchant)

    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{item.id}"

    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end