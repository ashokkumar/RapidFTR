Feature:

  As a user
  I want to go to flag a child's record
  So that I can identify suspect and duplicate records to admin

  Background:
   Given "Praful" is logged in
   And the following children exist in the system:
      | name   |
      | Peter |

  Scenario: Flagging a child record
    When I flag "Peter" as suspect with the following reason:
      """
      He is a bad guy.
      """
    Then the view record page should show the record is flagged
    And the edit record page should show the record is flagged
    And the record history should log "Record was flagged by praful because: He is a bad guy."
		And the child listing page filtered by flagged should show the following children:
			| Peter |
    
  Scenario: Removing flag from a child record
    Given I flag "Peter" as suspect
    When I am on the child record page for "Peter"
    And I unflag "Peter" with the following reason:
      """
      He is a not such a bad guy after all.
      """
    Then I should see "Child was successfully updated."
    And the record history should log "Record was unflagged by praful because: He is a not such a bad guy after all."

    Scenario: Seeing Flagged Child in Search Results
      Given the following children exist in the system:
        | name   | flag |
        | Paul   | false|
      And I flag "Peter" as suspect
      When I search using a name of "P"
      Then the "Peter" result should have a "flag" image
    