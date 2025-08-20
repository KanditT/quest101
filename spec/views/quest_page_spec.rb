# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Root Path', type: :request do
  describe 'GET /' do
    let!(:quest) { Quest.create!(name: 'Learn RSpec') } # rubocop:disable RSpec/LetSetup

    it 'renders the root page successfully' do # rubocop:disable RSpec/MultipleExpectations,RSpec/ExampleLength
      get root_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('My Academy Quest')
      expect(response.body).to include('Let&#39;s add more quest...')
      expect(response.body).to include('Create Quest')
      expect(response.body).to include('Learn RSpec')
    end
  end

  describe 'GET /brag' do
    it 'renders the brag page successfully' do # rubocop:disable RSpec/MultipleExpectations
      get brag_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('MY BRAG PAGE')
    end
  end
end
