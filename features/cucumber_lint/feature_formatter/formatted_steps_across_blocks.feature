Feature: feature formatter

  Scenario: formatted steps across blocks
    Given feature content
      """
      Feature: Test Feature

        Background:
          Given A

        Scenario: Test Scenario
          Given B
          When C
          Then D
      """
    Then the feature is formatted
