Feature: no_empty_features disabled

  Background:
    Given I have a file without a feature
    And I have no_empty_features disabled


  Scenario: lint
    When I run `cucumber_lint`
    Then I see the output
      """
      .

      1 file inspected (1 passed)
      """
    And it exits with status 0
