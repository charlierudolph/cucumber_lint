Feature: linting

  Scenario: a feature with unformatted table whitespace
    Given I have a feature with unformatted table whitespace
    When I run `cucumber_lint`
    Then I see the output
      """
      F

      ./features/test.feature:5: Fix table whitespace
      ./features/test.feature:17: Fix table whitespace

      1 file inspected (0 passed, 1 failed)
      """
    And it exits with status 1


  Scenario: a feature with formatted table whitespace
    Given I have a feature with formatted table whitespace
    When I run `cucumber_lint`
    Then I see the output
      """
      .

      1 file inspected (1 passed)
      """
    And it exits with status 0
