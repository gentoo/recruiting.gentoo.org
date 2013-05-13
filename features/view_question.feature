Feature: View a certain question
  As a candidate
  I want to view questions
  And answer them

  Background:
    Given I logged in as a "candidate"
    And sample question categories exist
    And I subscribed "Developer Quiz" question category

  Scenario: View subscribed question
    When I am on the "Developer Quiz" questions list page
    And I follow "Organizational structure questions 2"
    Then I should see button: "Submit"

  Scenario: View non subscribed question
    When I am on the "Staffer Quiz" questions list page
    And I follow "Organizational structure questions 3"
    Then I should see: "All"
    And I should not see button: "Submit"
