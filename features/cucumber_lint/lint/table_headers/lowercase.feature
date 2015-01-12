Feature: linting

  Background:
    Given I have configured table_headers to enforce lowercase


  Scenario: a feature with unformatted table headers (lowercase)
    Given I have a feature with unformatted table headers (lowercase)
    When I run `cucumber_lint`
    Then I see the output
      """
      F

      ./features/table_headers.feature:5: lowercase table headers
      ./features/table_headers.feature:13: lowercase "<VEGETABLE>"
      ./features/table_headers.feature:13: lowercase "<FRUIT>"
      ./features/table_headers.feature:14: lowercase "<CODE NAME>"
      ./features/table_headers.feature:17: lowercase table headers

      1 file inspected (0 passed, 1 failed)
      """
    And it exits with status 1


  Scenario: a feature with formatted table headers (lowercase)
    Given I have a feature with formatted table headers (lowercase)
    When I run `cucumber_lint`
    Then I see the output
      """
      .

      1 file inspected (1 passed)
      """
    And it exits with status 0
