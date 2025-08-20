# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'quests/edit' do
  let(:quest) do
    Quest.create!(
      name: 'MyString',
      status: false
    )
  end

  before do
    assign(:quest, quest)
  end

  it 'renders the edit quest form' do
    render

    assert_select 'form[action=?][method=?]', quest_path(quest), 'post' do
      assert_select 'input[name=?]', 'quest[name]'

      assert_select 'input[name=?]', 'quest[status]'
    end
  end
end
