# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'quests/index' do
  before do
    assign(:quests, [
             Quest.create!(
               name: 'Name',
               status: false
             ),
             Quest.create!(
               name: 'Name',
               status: false
             )
           ])
  end

  it 'renders a list of quests' do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new('Name'), count: 2
    assert_select cell_selector, text: Regexp.new(false.to_s), count: 2
  end
end
