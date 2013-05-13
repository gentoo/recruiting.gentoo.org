Feature: Quiz subscription
  As a recruit
  I want to subscribe to quizzes
  To answer questions

  Background:
    Given I logged in as a "candidate"
    And sample question categories exist

  Scenario: Subscribe to multiple quizzes
    When I follow "Question groups"
    And I subscribe to question group "Developer Quiz"
    And I follow "Question groups"
    And I subscribe to question group "Staffer Quiz"
    Then I should be subscribed to all question groups
