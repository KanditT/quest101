# features/quest.feature
Feature: My Academy Quest
  As a user
  I want to manage my quests
  So that I can track my academic progress

  Background:
    Given I am on the quests page
    Given the database is clean

  Scenario: View the quest page header
    Then I should see "My Academy Quest" as the main heading
    And I should see the profile section with "Kandit Tanthanathewin"
    And I should see "ƃuᴉɯ" in the profile
    And I should see a profile image
    And I should see a "Brag" button

  Scenario: Brag button functionality
    When I click the "Brag" button
    Then I should be redirected to the brag page

  Scenario: Quests list is dynamic
    Then I should see a quests container
    And the quests list should be within a turbo frame named "quests"

  Scenario: Responsive design elements
    When I resize the browser to mobile view
    Then the profile section should stack vertically
    When I resize the browser to desktop view
    Then the profile section should display horizontally

Scenario: Create a new quest successfully
    When I fill in the quest form with "Learn Ruby on Rails"
    And I submit the quest form
    Then I should see "Learn Ruby on Rails" in the quests list
    And the quest should have incomplete status
    When I delete the quest "Learn Ruby on Rails"
    Then I wait a bit
    And I should not see "Learn Ruby on Rails" in the quests list


  Scenario: Create multiple quests
    When I create a quest with name "Learn JavaScript"
    And I create a quest with name "Learn CSS"
    And I create a quest with name "Build a Portfolio"
    Then I wait a bit
    Then I should see "Learn JavaScript" in the quests list
    And I should see "Learn CSS" in the quests list
    And I should see "Build a Portfolio" in the quests list
    Then I wait a bit
    And the quest "Learn JavaScript" should have an incomplete status
    And the quest "Learn CSS" should have an incomplete status
    And the quest "Build a Portfolio" should have an incomplete status
    
  Scenario: Form validation works with Turbo Stream
    When I submit an invalid quest form
    Then the form should update in place without page refresh
    And I should see validation errors
    And the page URL should not change
