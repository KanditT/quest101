# frozen_string_literal: true

require 'rails_helper'

RSpec.describe QuestsController, type: :routing do # rubocop:disable RSpecRails/InferredSpecType
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/quests').to route_to('quests#index')
    end

    it 'routes to #toggle_status' do
      expect(patch: '/quests/1/toggle_status').to route_to('quests#toggle_status', id: '1')
    end

    it 'routes root to quests#index' do
      expect(get: '/').to route_to('quests#index')
    end
  end
end
