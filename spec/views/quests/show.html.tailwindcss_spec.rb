# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'quests/show' do
  before do
    assign(:quest, Quest.create!(
                     name: 'Name',
                     status: false
                   ))
  end

  it 'renders attributes in <p>' do # rubocop:disable RSpec/MultipleExpectations
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/false/)
  end
end
