require 'rails_helper'

RSpec.describe 'Items', type: :request do
  let!(:todo) { create(:todo) }
  let!(:items) { create_list(:item, 10, todo_id: todo.id) }
  let(:todo_id) { todo.id }
  let(:id) { items.first.id }

  describe 'GET /todos/:todo_id/items/todo_id/items' do
    before { get "/todos/#{todo_id}/items" }

    context 'when todo exists' do
      it 'returns all items' do
        expect(json).not_to be_empty
        expect(json.size).to eq(10)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when todo does not exist' do
      let!(:todo_id) { 0 }

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Todo/)
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'GET /todos/:todo_id/items/:id' do
    before { get "/todos/#{todo_id}/items/#{id}" }

    context 'when todo item exists' do
      it 'returns the item' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when todo item does not exist' do
      let!(:id) { 0 }

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Item/)
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'POST /todos/:todo_id/items' do
    let(:valid_attributes) { { name: 'Visit Narnia', done: false } }

    context 'when the request attributes are valid' do
      before { post "/todos/#{todo_id}/items", params: valid_attributes }

      it 'creates a todo' do
        expect(json['name']).to eq('Visit Narnia')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when a request attribute is invalid' do
      before { post "/todos/#{todo_id}/items", params: {} }

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PUT /todos/:todo_id/items/:id' do
    let(:valid_attributes) { { name: 'Mozart' } }
    before { put "/todos/#{todo_id}/items/#{id}", params: valid_attributes }

    context 'when the item exists' do
      it 'updates the todo item' do
        updated_item = Item.find(id)
        expect(updated_item.name).to eq('Mozart')
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'when the todo item does not exist' do
      let(:id) { 0 }

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Item/)
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'DELETE /todos/:todo_id/items/:id' do
    before { delete "/todos/#{todo_id}/items/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
