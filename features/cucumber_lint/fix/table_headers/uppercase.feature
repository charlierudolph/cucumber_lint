Feature: fixing

  Background:
    Given I have configured table_headers to enforce uppercase


  Scenario: a feature with unformatted table headers (uppercase)
    Given I have a feature with unformatted table headers (uppercase)
    When I run `cucumber_lint --fix`
    Then I see the output
      """
      W

      1 file inspected (0 passed, 1 written)
      """
    And it exits with status 0
    And I now have a feature with formatted table headers (uppercase)


  Scenario: a feature with formatted table headers (uppercase)
    Given I have a feature with formatted table headers (uppercase)
    When I run `cucumber_lint --fix`
    Then I see the output
      """
      .

      1 file inspected (1 passed)
      """
    And it exits with status 0
