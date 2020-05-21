require 'rails_helper'

RSpec.describe 'Merchant API request: ' do
  it 'Index' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants_response = JSON.parse(response.body)

    expect(merchants_response.keys).to contain_exactly('data')
    expect(merchants_response['data'].length).to eq(3)
    expect(merchants_response['data'][0].keys).to contain_exactly('id', 'type', 'attributes')
    expect(merchants_response['data'][0]['attributes'].keys).to contain_exactly('name')
  end

  it "Show" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    expect(response).to be_successful

    merchant_response = JSON.parse(response.body)

    expect(merchant_response.keys).to contain_exactly('data')
    expect(merchant_response['data'].keys).to contain_exactly('id', 'type', 'attributes')
    expect(merchant_response['data']['id']).to eq("#{id}")
    expect(merchant_response['data']['attributes'].keys).to contain_exactly('name')
  end

  it "Create" do
    merchant_params = { "name" => "Scumpus\' Bait and Tackle" }

    post '/api/v1/merchants', params: merchant_params

    expect(response).to be_successful

    merchant_response = JSON.parse(response.body)

    expect(merchant_response.keys).to contain_exactly('data')
    expect(merchant_response['data'].keys).to contain_exactly('id', 'type', 'attributes')
    expect(merchant_response['data']['attributes'].keys).to contain_exactly('name')
    expect(merchant_response['data']['attributes']['name']).to eq("Scumpus\' Bait and Tackle")
  end

  it "Update" do
    previous_name = "Rungo's Beach Bar"
    id = create(:merchant, name: previous_name).id
    merchant_params = { "name" => "Scumpus\' Bait and Tackle" }

    put "/api/v1/merchants/#{id}", params: merchant_params

    expect(response).to be_successful

    merchant_resource = Merchant.find_by(id: id)
    merchant_response = JSON.parse(response.body)

    expect(merchant_resource.name).to eq("Scumpus\' Bait and Tackle")
    expect(merchant_response.keys).to contain_exactly('data')
    expect(merchant_response['data'].keys).to contain_exactly('id', 'type', 'attributes')
    expect(merchant_response['data']['attributes'].keys).to contain_exactly('name')
    expect(merchant_response['data']['attributes']['name']).to_not eq("Rungo's Beach Bar")
    expect(merchant_response['data']['attributes']['name']).to eq("Scumpus\' Bait and Tackle")
  end

  it "Destroy" do
    merchant = create(:merchant)

    expect{ delete "/api/v1/merchants/#{merchant.id}" }.to change(Merchant, :count).by(-1)

    expect(response).to be_success
    expect{Merchant.find(merchant.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "Merchant Items" do
    merchant = create(:merchant) do |merchant|
      10.times do
        merchant.items.create(attributes_for(:item))
      end
    end

    # binding.pry

  end
end
