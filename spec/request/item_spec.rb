require 'rails_helper'

RSpec.describe 'items API', type: :request do

  # Initialize test data
  let!(:items) { create_list(:item, 10) }
  let!(:item_id) { items.first.id }

  # Test suite for GET /items
  describe 'GET /items' do
    # Make HTTP request before each example
    before { get '/items' }

    it 'returns items' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /items/:id
  describe 'GET /items/:id' do
    before { get "/items/#{item_id}" }

    context 'when the record exists' do
      it 'returns the item' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(item_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when record does not exist' do
      let (:item_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not-found message' do
        expect(response.body).to match("{\"message\":\"Couldn't find Item with 'id'=100\"}")
      end
    end
  end

  # Test suite for POST /items
  describe 'POST /items' do
    # Valid payload
    let(:valid_attributes) { { name: 'Apples', amount: 4, section: 'Produce' } }

    context 'when the request is valid' do
      before { post '/items', params: valid_attributes }

      it 'creates an item' do
        expect(json['name']).to eq('Apples')
        expect(json['amount']).to eq(4)
        expect(json['section']).to eq('Produce')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/items', params: { name: 'Foobar', amount: 1 } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match("{\"message\":\"Validation failed: Section can't be blank\"}")
      end
    end
  end

  # Test suite for PUT /items/:id
  describe 'PUT /items/:id' do
    let(:valid_attributes) { { number: 7 } }

    context 'when the record exists' do
      before { put "/items/#{item_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /items/:id
  describe 'DELETE /items/:id' do
    before { delete "/items/#{item_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end

end
