Feature: table formatter

  Scenario: unformatted steps
    Given steps
      """
      Given A
      Given B
      When C
      Then D
      Then E
      """
    Then the formatted steps are
      """
      Given A
      And B
      When C
      Then D
      And E
      """

  Scenario: formatted steps
    Given steps
      """
      Given A
      And B
      When C
      Then D
      And E
      """
    Then the steps are formatted
