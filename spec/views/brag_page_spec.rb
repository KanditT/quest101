# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Brag Page', type: :feature do
  describe 'page structure and content' do
    before { visit brag_path }

    it 'displays the page title' do
      expect(page).to have_css('[data-test-id="brag-title"]', text: 'My Brag Page')
    end

    it 'shows the back button with correct link' do # rubocop:disable RSpec/MultipleExpectations
      expect(page).to have_css('[data-test-id="back-to-quests-button"]')
      expect(page).to have_link('Back', href: quests_path)
    end

    it 'displays the main header and subtitle' do # rubocop:disable RSpec/MultipleExpectations
      expect(page).to have_css('[data-test-id="brag-header"]')
      expect(page).to have_text('Goals & Actions 2025')
      expect(page).to have_text('My journey to improvement')
    end

    it 'shows all goal items' do # rubocop:disable RSpec/ExampleLength,RSpec/MultipleExpectations
      expect(page).to have_css('[data-test-id="goal-item-1"]')
      expect(page).to have_text('Typing: able to type at speed 55 wpm with accuracy 95%')

      expect(page).to have_css('[data-test-id="goal-item-2"]')
      expect(page).to have_text('English: improve my English skill and achieve IELTS band 6.0 plus')

      expect(page).to have_css('[data-test-id="goal-item-3"]')
      expect(page).to have_text('Understand and apply: Git and Scrum')
    end

    it 'displays all action sections' do # rubocop:disable RSpec/MultipleExpectations
      expect(page).to have_css('[data-test-id="self-actions"]', text: '📚 Self')
      expect(page).to have_css('[data-test-id="team-actions"]', text: '👥 Team')
      expect(page).to have_css('[data-test-id="odt-actions"]', text: '🏫 ODT')
      expect(page).to have_css('[data-test-id="client-actions"]', text: '🤝 Client')
    end
  end

  describe 'navigation' do
    it 'navigates back to quests page when back button is clicked' do
      visit brag_path
      click_link 'Back'
      expect(page).to have_current_path(quests_path, ignore_query: true)
    end
  end

  describe 'responsive design' do
    it 'has proper responsive classes' do
      visit brag_path
      expect(page).to have_css('.max-w-3xl.mx-auto.py-12')
    end
  end

  describe 'visual styling and layout' do
    before { visit brag_path }

    it 'has proper gradient lines for visual separation' do # rubocop:disable RSpec/MultipleExpectations
      expect(page).to have_css('.h-px.bg-gradient-to-r')
      expect(page).to have_css('.border-l-2.border-r-2.border-gray-200')
    end

    it 'displays numbered goal items with proper styling' do # rubocop:disable RSpec/MultipleExpectations
      within('[data-test-id="goal-item-1"]') do
        expect(page).to have_css('.text-amber-500.font-medium', text: '1.')
        expect(page).to have_css('.text-gray-700.font-medium', text: 'Typing:')
      end
    end

    it 'shows action sections with proper icons and styling' do # rubocop:disable RSpec/MultipleExpectations
      expect(page).to have_css('[data-test-id="self-actions"] .text-amber-600', text: '📚 Self')
      expect(page).to have_css('[data-test-id="team-actions"] .text-amber-600', text: '👥 Team')
      expect(page).to have_css('[data-test-id="odt-actions"] .text-amber-600', text: '🏫 ODT')
      expect(page).to have_css('[data-test-id="client-actions"] .text-amber-600', text: '🤝 Client')
    end

    it 'has hover effects on goal and action items' do # rubocop:disable RSpec/MultipleExpectations
      expect(page).to have_css('[data-test-id="goal-item-1"].hover\\:border-gray-300')
      expect(page).to have_css('[data-test-id="self-actions"].hover\\:border-gray-300')
    end
  end

  describe 'content sections' do
    before { visit brag_path }

    it 'displays the correct goal section title' do
      expect(page).to have_css('[data-test-id="goal-section-title"]', text: 'Goals for this year (2025)')
    end

    it 'displays the correct action section title' do
      expect(page).to have_css('[data-test-id="action-section-title"]', text: 'Action & Contribution 🚀')
    end

    it 'shows specific self-improvement actions' do # rubocop:disable RSpec/MultipleExpectations
      within('[data-test-id="self-actions"]') do
        expect(page).to have_text('Learn ENG from Speechful/Duolingo: at least 1 lesson per day')
        expect(page).to have_text('Learn everyday at ODT')
        expect(page).to have_text('Typing 20 mins everyday for 2 months')
      end
    end

    it 'shows team collaboration actions' do
      within('[data-test-id="team-actions"]') do
        expect(page).to have_text('Communicate more with team')
      end
    end

    it 'shows ODT learning actions' do
      within('[data-test-id="odt-actions"]') do
        expect(page).to have_text('Learning and improve at Academy ODT')
      end
    end

    it 'shows client work actions' do # rubocop:disable RSpec/MultipleExpectations
      within('[data-test-id="client-actions"]') do
        expect(page).to have_text('Working on BMA project')
        expect(page).to have_text('Working on TMLT project')
      end
    end
  end

  describe 'accessibility and structure' do
    before { visit brag_path }

    it 'has proper heading hierarchy' do # rubocop:disable RSpec/MultipleExpectations
      expect(page).to have_css('h1', text: 'My Brag Page')
      expect(page).to have_css('h2', text: 'My journey to improvement')
      expect(page).to have_css('h3')
    end

    it 'has proper list structure for goals' do
      expect(page).to have_css('[data-test-id="goal-list"] li', count: 3)
    end

    it 'has proper list structure for actions with bullet points' do
      expect(page).to have_css('.list-disc.ml-5.text-gray-700.marker\\:text-amber-400')
    end

    it 'uses semantic HTML elements' do # rubocop:disable RSpec/MultipleExpectations
      expect(page).to have_css('ul')
      expect(page).to have_css('li')
      expect(page).to have_css('h1, h2, h3')
    end
  end

  describe 'interactive elements' do
    before { visit brag_path }

    it 'has a functional back button with correct styling' do # rubocop:disable RSpec/MultipleExpectations
      back_button = find('[data-test-id="back-to-quests-button"]')
      expect(back_button[:class]).to include('border-gray-300')
      expect(back_button[:class]).to include('hover:border-gray-400')
      expect(back_button[:class]).to include('transition-colors')
    end

    it 'back button has proper icon' do
      within('[data-test-id="back-to-quests-button"]') do
        expect(page).to have_css('svg.rotate-180')
      end
    end
  end
end
