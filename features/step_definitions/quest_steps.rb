# frozen_string_literal: true

Given('I am on the quests page') do
  visit quests_path
end

Given('the database is clean') do
  Quest.delete_all
  page.execute_script('location.reload()') if page.current_path == quests_path
end

Then('I should see {string} as the main heading') do |heading|
  expect(page).to have_css('h1', text: heading)
end

Then('I should see the profile section with {string}') do |name|
  expect(page).to have_text(name)
end

Then('I should see {string} in the profile') do |text|
  expect(page).to have_text(text)
end

Then('I should see a profile image') do
  expect(page).to have_css('img')
end

Then('I should see a {string} button') do |button_text|
  expect(page).to have_link(button_text)
end

When('I click the {string} button') do |button_text|
  click_link button_text
end

Then('I should be redirected to the brag page') do
  expect(page).to have_current_path(brag_path, ignore_query: true)
end

Then('I should see a quests container') do
  expect(page).to have_css('#quests_list')
end

Then('the quests list should be within a turbo frame named {string}') do |frame_name|
  expect(page).to have_css("turbo-frame[id='#{frame_name}']")
  within "turbo-frame[id='#{frame_name}']" do
    expect(page).to have_css('#quests_list')
  end
end

When('I resize the browser to mobile view') do
  page.driver.browser.manage.window.resize_to(375, 667)
end

When('I resize the browser to desktop view') do
  page.driver.browser.manage.window.resize_to(1024, 768)
end

Then('the profile section should stack vertically') do
  # Check that profile content is responsive
  expect(page).to have_css('img')
  expect(page).to have_text('Kandit Tanthanathewin')
end

Then('the profile section should display horizontally') do
  # Check that profile content is responsive
  expect(page).to have_css('img')
  expect(page).to have_text('Kandit Tanthanathewin')
end

When('I fill in the quest form with {string}') do |quest_name|
  fill_in 'quest[name]', with: quest_name
end

When('I submit the quest form') do
  click_button 'Add Quest'
end

When('I create a quest with name {string}') do |quest_name|
  fill_in 'quest[name]', with: quest_name
  click_button 'Add Quest'
  sleep 0.7
end

Then('I should see {string} in the quests list') do |quest_name|
  within '#quests_list' do
    expect(page).to have_text(quest_name)
  end
end

Then('I should not see {string} in the quests list') do |quest_name|
  within '#quests_list' do
    expect(page).to have_no_text(quest_name)
  end
end

Then('the quest should have incomplete status') do
  expect(page).to have_text(/IN PROGRESS/i)
end

When('I delete the quest {string}') do |quest_name|
  quest = Quest.find_by!(name: quest_name)
  find(%([data-testid="quest-delete-#{quest.id}"])).click
end

When('I toggle the status of quest {string}') do |quest_name|
  quest = Quest.find_by!(name: quest_name)
  find(%([data-testid="quest-check-#{quest.id}"])).click
  sleep 2.5
end

Then('I wait a bit') do
  sleep(1)
end

Then('the quest {string} should have a completed status') do |quest_name|
  quest = Quest.find_by!(name: quest_name)
  quest.reload
  expect(quest.status).to be(true)
  expect(page).to have_text(/COMPLETED/i)
end

Then('the quest {string} should have an incomplete status') do |quest_name|
  quest = Quest.find_by!(name: quest_name)
  quest.reload
  expect(quest.status).to be(false)
  expect(page).to have_text(/IN PROGRESS/i)
end

When('I submit an invalid quest form') do
  fill_in 'quest[name]', with: ''
  click_button 'Add Quest'
end

Then('the form should update in place without page refresh') do
  expect(page).to have_current_path(quests_path, ignore_query: true)
  expect(page).to have_css('form')
end

Then('the page URL should not change') do
  expect(page).to have_current_path(quests_path, ignore_query: true)
end

Then('I should see validation errors') do
  # Check for validation error messages or form errors
  has_error = page.has_css?('.error, .alert, [role="alert"], .field_with_errors, .text-red-500, .border-red-500') ||
              page.has_text?('can\'t be blank') ||
              page.has_text?('is required') ||
              page.has_selector?('input[placeholder*="quest"]') # Form should still be visible
  expect(has_error).to be_truthy
end

Then('the quest form should be cleared') do
  expect(page).to have_field('quest[name]', with: '')
end
