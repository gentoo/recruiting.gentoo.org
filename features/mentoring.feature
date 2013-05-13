Feature: Mentoring
  As Gentoo developer
  I want to mentor recruits
  So they join can join us

  Background:
    Given I logged in as an "mentor"
    And sample recruits exist

  Scenario: Comment an answer
    When I follow "Answers to review"
    And I follow first link "Review"
    Then I should not see "Some remark"
    When I fill in "comment_comment" with "Some remark"
    And press "Comment"
    Then I should see "Some remark"
