Feature: Brag Page
  As a user
  I want to view my goals and achievements
  So that I can track my progress

  Background:
    Given I am on the brag page

  Scenario: View page content and navigation
    Then I should see "My Brag Page" as the main title
    And I should see "Goals & Actions 2025" 
    And I should see a back button to quests

  Scenario: View goals and actions
    Then I should see the 3 main goals
    And I should see all 4 action categories
    And I should see specific actions for each category