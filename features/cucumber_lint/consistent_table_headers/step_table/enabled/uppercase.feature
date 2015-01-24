Feature: consistent_table_headers enforcing uppercase for a step table

  Background:
    Given I have a feature with content
      """
      Feature: Test Feature

        Scenario: Test Scenario
          Given a table
            | VEGETABLE | code name |
            | Asparagus | Alpha     |
            | Broccoli  | Bravo     |
            | Carrot    | Charlie   |
          Then my tests pass
      """
    And I have consistent_table_headers enforcing uppercase


  Scenario: lint
    When I run `cucumber_lint`
    Then I see the output
      """
      F

      ./features/test.feature:5: uppercase table headers

      1 file inspected (0 passed, 1 failed)
      """
    And it exits with status 1


  Scenario: fix
    When I run `cucumber_lint --fix`
    Then I see the output
      """
      W

      1 file inspected (0 passed, 1 written)
      """
    And it exits with status 0
    And my feature now has content
      """
      Feature: Test Feature

        Scenario: Test Scenario
          Given a table
            | VEGETABLE | CODE NAME |
            | Asparagus | Alpha     |
            | Broccoli  | Bravo     |
            | Carrot    | Charlie   |
          Then my tests pass
      """
