require 'rails_helper'

RSpec.describe 'Todos API', type: :request do
  let(:user) { create(:user) }
  let!(:todos) { create_list(:todo, 10, created_by: user.id) }
  let(:id) { todos.first.id }
  let(:headers) { valid_headers }

  describe 'GET /todos' do
    before do
      get '/todos', params: {}, headers: headers
    end

    context 'V1' do
      let(:headers) { valid_headers('v1') }

      it 'returns todos' do
        expect(json).not_to be_empty
        expect(json.size).to eq(10)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'V2' do
      let(:headers) { valid_headers('v2') }

      it 'returns a message' do
        expect(json).not_to be_empty
        expect(JSON.parse(response.body)['message']).to eq('This is the verion 2 of Todos')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET /todos/:id' do
    before do
      get "/todos/#{id}", params: {}, headers: headers
    end

    context 'when the todo exists' do
      it 'returns the todo' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the todo does not exist' do
      let(:id) { 0 }

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Todo/)
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'POST /todos' do
    let(:valid_attributes) do
      {
        title: 'Learn Elm',
        created_by: user.id.to_s
      }.to_json
    end

    context 'when the request is valid' do
      before do
        post '/todos', params: valid_attributes, headers: headers
      end

      it 'creates a todo' do
        expect(json['title']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) do
        {
          title: nil
        }.to_json
      end
      before do
        post '/todos', params: invalid_attributes, headers: headers
      end

      it 'returns a validation failure message' do
        expect(json['message']).to match(/Validation failed: Title can't be blank/)
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PUT /todos/:id' do
    let(:valid_attributes) { { title: 'Shopping' }.to_json }

    context 'when the todo exists' do
      before do
        put "/todos/#{id}", params: valid_attributes, headers: headers
      end

      it 'updates the todo' do
        updated_todo = Todo.find(id)
        expect(updated_todo.title).to eq('Shopping')
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'when the todo does not exist' do
      before do
        put "/todos/#{id}", params: valid_attributes, headers: headers
      end

      let(:id) { 0 }

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Todo/)
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'DELETE /todos/:id' do
    before do
      delete "/todos/#{id}", params: {}, headers: headers
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
