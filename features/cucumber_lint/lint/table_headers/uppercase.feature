Feature: linting

  Background:
    Given I have configured table_headers to enforce uppercase


  Scenario: a feature with unformatted table headers (uppercase)
    Given I have a feature with unformatted table headers (uppercase)
    When I run `cucumber_lint`
    Then I see the output
      """
      F

      ./features/table_headers.feature:5: uppercase table headers
      ./features/table_headers.feature:13: uppercase "<vegetable>"
      ./features/table_headers.feature:13: uppercase "<fruit>"
      ./features/table_headers.feature:14: uppercase "<code name>"
      ./features/table_headers.feature:17: uppercase table headers

      1 file inspected (0 passed, 1 failed)
      """
    And it exits with status 1


  Scenario: a feature with formatted table headers (uppercase)
    Given I have a feature with formatted table headers (uppercase)
    When I run `cucumber_lint`
    Then I see the output
      """
      .

      1 file inspected (1 passed)
      """
    And it exits with status 0
