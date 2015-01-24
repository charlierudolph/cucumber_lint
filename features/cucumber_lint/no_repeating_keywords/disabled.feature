Feature: no_repeating_keywords disabled

  Background:
    Given I have a feature with content
      """
      Feature: Test Feature

        Scenario: Test Scenario
          Given A
          Given B
          Given C
          When D
          When E
          When F
          Then G
          Then H
          Then I
      """
    And I have no_repeating_keywords disabled


  Scenario: lint
    When I run `cucumber_lint`
    Then I see the output
      """
      .

      1 file inspected (1 passed)
      """
    And it exits with status 0
