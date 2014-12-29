Feature: feature formatter

  Scenario: unformatted steps
    Given feature content
      """
      Feature: Test Feature

        Scenario: Test Scenario
          Given A
          Given B
          When C
          Then D
          Then E
      """
    Then the formatted feature content is
      """
      Feature: Test Feature

        Scenario: Test Scenario
          Given A
          And B
          When C
          Then D
          And E
      """
