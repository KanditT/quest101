# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Quests', type: :request do # rubocop:disable RSpecRails/InferredSpecType
  describe 'GET /quests' do
    it 'can render quests index path' do
      get quests_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /quests' do
    let(:valid_params) { { quest: { name: 'Valid Quest Name' } } }
    let(:invalid_params) { { quest: { name: '' } } }

    context 'with valid parameters' do
      it 'can create a new quest' do
        expect { post quests_path, params: valid_params }
          .to change(Quest, :count).by(1)
      end

      it 'creates quest with status false' do
        post quests_path, params: valid_params
        expect(Quest.last.status).to be(false)
      end

      it 'creates quest with correct name' do
        post quests_path, params: valid_params
        expect(Quest.last.name).to eq('Valid Quest Name')
      end

      it 'redirects to quests index with HTML format' do
        post quests_path, params: valid_params
        expect(response).to redirect_to(quests_path)
      end

      it 'responds with 302 redirect for HTML format' do
        post quests_path, params: valid_params
        expect(response).to have_http_status(:found)
      end
    end

    context 'with Turbo Stream format' do
      let(:turbo_headers) { { 'Accept' => 'text/vnd.turbo-stream.html' } }

      context 'with valid parameters' do # rubocop:disable RSpec/NestedGroups
        it 'creates a quest successfully' do
          expect do
            post quests_path, params: valid_params, headers: turbo_headers
          end.to change(Quest, :count).by(1)
        end

        it 'responds with turbo_stream content type' do
          post quests_path, params: valid_params, headers: turbo_headers
          expect(response.content_type).to include('text/vnd.turbo-stream.html')
        end

        it 'responds with status ok' do
          post quests_path, params: valid_params, headers: turbo_headers
          expect(response).to have_http_status(:ok)
        end
      end

      context 'with invalid parameters' do # rubocop:disable RSpec/NestedGroups
        it 'does not create a quest' do
          expect do
            post quests_path, params: invalid_params, headers: turbo_headers
          end.not_to change(Quest, :count)
        end

        it 'responds with turbo_stream content type for errors' do
          post quests_path, params: invalid_params, headers: turbo_headers
          expect(response.content_type).to include('text/vnd.turbo-stream.html')
        end

        it 'responds with status ok for validation errors' do
          post quests_path, params: invalid_params, headers: turbo_headers
          expect(response).to have_http_status(:ok)
        end
      end
    end
  end

  describe 'DELETE /quests/:id' do
    it 'can delete quest' do
      quest = Quest.create!(name: 'TEST2')
      expect do
        delete quest_path(quest)
      end.to change(Quest, :count).by(-1)
    end
  end

  describe 'PATCH /quests/:id/toggle_status' do
    it 'can toggle to change status quest' do
      quest = Quest.create!(name: 'TEST3', status: false)
      patch toggle_status_quest_path(quest) # Updated to use toggle_status route
      quest.reload
      expect(quest.status).to be(true)
    end

    it 'can toggle status from true to false' do
      quest = Quest.create!(name: 'TEST4', status: true)
      patch toggle_status_quest_path(quest)
      quest.reload
      expect(quest.status).to be(false)
    end
  end

  describe 'with Turbo Stream requests' do
    describe 'POST /quests' do
      it 'responds with turbo_stream content type' do
        post quests_path, params: { quest: { name: 'TEST5' } },
                          headers: { 'Accept' => 'text/vnd.turbo-stream.html' }
        expect(response.content_type).to include('text/vnd.turbo-stream.html')
      end

      it 'responds with status ok' do
        post quests_path, params: { quest: { name: 'TEST5' } },
                          headers: { 'Accept' => 'text/vnd.turbo-stream.html' }
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'DELETE /quests/:id' do
      it 'responds correctly' do
        quest = Quest.create!(name: 'Delete Test')
        delete quest_path(quest),
               headers: { 'Accept' => 'text/vnd.turbo-stream.html' }
        expect(response.content_type).to include('text/vnd.turbo-stream.html')
      end
    end

    describe 'PATCH /quests/:id/toggle_status' do
      it 'responds correctly' do
        quest = Quest.create!(name: 'Toggle Test', status: false)
        patch toggle_status_quest_path(quest),
              headers: { 'Accept' => 'text/vnd.turbo-stream.html' }
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'error handling' do
    describe 'DELETE /quests/:id with non-existent quest' do
      it 'handles missing quest gracefully' do
        expect do
          delete quest_path(id: 999_999)
        end.not_to raise_error
      end
    end
  end
end
