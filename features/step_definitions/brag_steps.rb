# frozen_string_literal: true

Given('I am on the brag page') do
  visit brag_path
end

Then('I should see {string} as the main title') do |title|
  expect(page).to have_css('[data-test-id="brag-title"]', text: title)
end

Then('I should see {string} in the header') do |header_text|
  within('[data-test-id="brag-header"]') do
    expect(page).to have_text(header_text)
  end
end

Then('I should see {string} as the subtitle') do |subtitle|
  expect(page).to have_css('[data-test-id="brag-subtitle"]', text: subtitle)
end

Then('I should see the goals section with title {string}') do |section_title|
  expect(page).to have_css('[data-test-id="goal-section-title"]', text: section_title)
end

Then('I should see {int} goals listed:') do |count, table|
  expect(page).to have_css('[data-test-id="goal-list"] li', count: count)

  table.hashes.each_with_index do |row, index|
    goal_item = "[data-test-id=\"goal-item-#{index + 1}\"]"
    expect(page).to have_selector(goal_item, text: row['Goal'])
    expect(page).to have_selector(goal_item, text: row['Description'])
  end
end

Then('I should see {string} section') do |section_title|
  expect(page).to have_css('[data-test-id="action-section-title"]', text: section_title)
end

Then('I should be redirected to the quests page') do
  expect(page).to have_current_path(quests_path, ignore_query: true)
end

Then('the page should have proper container styling') do
  expect(page).to have_css('.container.mx-auto')
end

Then('all sections should have appropriate borders and backgrounds') do
  expect(page).to have_css('.border-2.border-sky-100')
  expect(page).to have_css('.bg-white.shadow-md')
end

Then('I should see the following action categories:') do |table| # rubocop:disable Metrics/BlockLength
  table.hashes.each do |row|
    category = row['Category']
    items = row['Items'].split(', ')

    case category
    when '📚 Self'
      within('[data-test-id="self-actions"]') do
        expect(page).to have_text(category)
        items.each { |item| expect(page).to have_text(item) }
      end
    when '👥 Team'
      within('[data-test-id="team-actions"]') do
        expect(page).to have_text(category)
        items.each { |item| expect(page).to have_text(item) }
      end
    when '🏫 ODT'
      within('[data-test-id="odt-actions"]') do
        expect(page).to have_text(category)
        items.each { |item| expect(page).to have_text(item) }
      end
    when '🤝 Client'
      within('[data-test-id="client-actions"]') do
        expect(page).to have_text(category)
        items.each { |item| expect(page).to have_text(item) }
      end
    end
  end
end

Then('the back button should have hover effects') do
  back_button = find('[data-test-id="back-to-quests-button"]')

  expect(back_button[:class]).to include('hover:bg-blue-600')
  expect(back_button[:class]).to include('hover:text-white')
  expect(back_button[:class]).to include('transition-all')
end
