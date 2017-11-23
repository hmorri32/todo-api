require 'rails_helper'

RSpec.describe "TODO api", type: :request do
  let!(:todos)   { create_list(:todo, 10) }
  let!(:todo_id) { todos.first.id }

  describe "GET /todos" do
    before { get '/todos' }

    it "returns yung todos" do
      expect(json).to_not be_empty
    end

    it "is chill" do
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /todos/:id" do
    before { get "/todos/#{todo_id}" }

    context "when it exists" do
      it 'returns that todo' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(todo_id)
      end

      it 'sends 200' do
        expect(response).to have_http_status(200)
      end
    end

    context "when said record does not exist" do
      let(:todo_id) { 100 }

      it 'returns status 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns error message' do
        expect(response.body).to match(/Couldn't find Todo/)
      end
    end
  end

  describe "POST /todos" do
    let(:valid_attributes) { { title: '2Fresh', created_by: 'me' } }

    context "valid request" do
      before { post '/todos', params: valid_attributes }

      it 'creates a todo' do
        expect(json['title']).to eq('2Fresh')
      end

      it 'returns 201' do
        expect(response).to have_http_status(201)
      end
    end

    context('invalid response') do
      before { post '/todos', params: { title: 'Ultra Invalid' } }

      it 'returns 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns error message' do
        expect(response.body).to match(/Validation failed: Created by can't be blank/)
      end
    end
  end

  describe "PUT /todos/:id" do
    let(:valid_attributes) { { title: 'Burrits' } }

    context "when record exists" do
      before { put "/todos/#{todo_id}", params: valid_attributes }

      it 'edits record' do
        expect(response.body).to be_empty
      end

      it 'returns 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe "DELETE /todos/:id" do
    before { delete "/todos/#{todo_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end