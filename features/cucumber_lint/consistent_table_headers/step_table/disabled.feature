Feature: consistent_table_headers disabled for a step table

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
    And I have consistent_table_headers disabled


  Scenario: lint
    When I run `cucumber_lint`
    Then I see the output
      """
      .

      1 file inspected (1 passed)
      """
    And it exits with status 0
