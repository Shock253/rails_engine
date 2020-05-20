require 'rails_helper'

RSpec.describe 'Merchant API request: ' do
  it 'Index' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful
  end
end
