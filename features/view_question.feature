Feature: View a certain question
  As a candidate
  I want to view questions
  And answer them

  Scenario: View subscribed question
    Given I logged in as a "candidate"
    When I am on the "Developer Quiz" questions list page
    And I follow "Organizational structure questions 2"
    Then I should see button: "Submit"

  Scenario: View non subscribed question
    Given I logged in as a "candidate"
    When I am on the "Staffer Quiz" questions list page
    And I follow "Organizational structure questions 1"
    Then I should see: "All"
    And I should not see button: "Submit"

