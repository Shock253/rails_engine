require 'rails_helper'

RSpec.describe 'Merchant API request: ' do
  it 'Index' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants.keys).to contain_exactly('data')
    expect(merchants['data'].length).to eq(3)
    expect(merchants['data'][0].keys).to contain_exactly('id', 'type', 'attributes')
    expect(merchants['data'][0]['attributes'].keys).to contain_exactly('name')
  end

  it "Show" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant.keys).to contain_exactly('data')
    expect(merchant['data'].keys).to contain_exactly('id', 'type', 'attributes')
    expect(merchant['data']['id']).to eq("#{id}")
    expect(merchant['data']['attributes'].keys).to contain_exactly('name')
  end
end
