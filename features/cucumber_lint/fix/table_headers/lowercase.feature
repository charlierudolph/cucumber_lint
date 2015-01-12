Feature: linting

  Background:
    Given I have configured table_headers to enforce lowercase


  Scenario: a feature with unformatted table headers (lowercase)
    Given I have a feature with unformatted table headers (lowercase)
    When I run `cucumber_lint --fix`
    Then I see the output
      """
      W

      1 file inspected (0 passed, 1 written)
      """
    And it exits with status 0
    And I now have a feature with formatted table headers (lowercase)


  Scenario: a feature with formatted table headers (lowercase)
    Given I have a feature with formatted table headers (lowercase)
    When I run `cucumber_lint --fix`
    Then I see the output
      """
      .

      1 file inspected (1 passed)
      """
    And it exits with status 0
