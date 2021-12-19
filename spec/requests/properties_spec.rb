require 'rails_helper'

describe 'Properties', type: :request do
  describe 'index path' do
    it 'respond with http success status code' do
      get "/"
      expect(response).to have_http_status(:ok)
      expect(response.status).to eq(200)
    end
  end
  describe 'show path' do
    it 'respond with http success status code' do
        get "/"
        property_id="EB-C0147"
        get "/properties/#{property_id}"
        expect(response).to have_http_status(:ok)
        expect(response.status).to eq(200)
    end
  end

  describe 'create_contact' do
    it 'redirect to home when contact message is sent correctly' do
        property_id="EB-C0147"
        params = {contact: {name: 'Aristoteles',phone: "724536",email:"aris@mail.com",message:"Contact me!!" }}
        post "/properties/#{property_id}/new_contact", params: params
        expect(response.status).to eq(302)
    end
  end
end
