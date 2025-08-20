# frozen_string_literal: true

Given('I am on the brag page') do
  visit brag_path
end

Then('I should see {string} as the main title') do |title|
  expect(page).to have_css('[data-test-id="brag-title"]', text: title)
end

Then('I should see {string}') do |text|
  expect(page).to have_text(text)
end

Then('I should see a back button to quests') do
  expect(page).to have_css('[data-test-id="back-to-quests-button"]')
  expect(page).to have_link('Back', href: quests_path)
end

Then('I should see the 3 main goals') do
  expect(page).to have_css('[data-test-id="goal-item-1"]')
  expect(page).to have_css('[data-test-id="goal-item-2"]')
  expect(page).to have_css('[data-test-id="goal-item-3"]')
  expect(page).to have_text('Typing')
  expect(page).to have_text('English')
  expect(page).to have_text('Understand and apply')
end

Then('I should see all 4 action categories') do
  expect(page).to have_css('[data-test-id="self-actions"]', text: '📚 Self')
  expect(page).to have_css('[data-test-id="team-actions"]', text: '👥 Team')
  expect(page).to have_css('[data-test-id="odt-actions"]', text: '🏫 ODT')
  expect(page).to have_css('[data-test-id="client-actions"]', text: '🤝 Client')
end

Then('I should see specific actions for each category') do
  expect(page).to have_text('Learn ENG from Speechful/Duolingo')
  expect(page).to have_text('Communicate more with team')
  expect(page).to have_text('Learning and improve at Academy ODT')
  expect(page).to have_text('Working on BMA project')
end
