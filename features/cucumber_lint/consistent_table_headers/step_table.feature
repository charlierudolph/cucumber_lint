Feature: consistent_table_headers for a step table

  Background:
    Given I have a feature with content
      """
      Feature: Test Feature

        Scenario: Test Scenario
          Given a table
            | VEGETABLE | fruit  | Code Name |
            | Asparagus | Apple  | Alpha     |
            | Broccoli  | Banana | Bravo     |
            | Carrot    | Cherry | Charlie   |
          Then my tests pass
      """

  Scenario: disabled
    Given I have "consistent_table_headers" disabled
    When I run `cucumber_lint`
    Then it passes

  Scenario: uppercase - lint and fix
    Given I have "consistent_table_headers" enabled with "enforced_style" as "uppercase"
    When I run `cucumber_lint`
    Then it fails with
      | LINE | MESSAGE                 |
      | 5    | uppercase table headers |
    When I run `cucumber_lint --fix`
    Then my feature now has content
      """
      Feature: Test Feature

        Scenario: Test Scenario
          Given a table
            | VEGETABLE | FRUIT  | CODE NAME |
            | Asparagus | Apple  | Alpha     |
            | Broccoli  | Banana | Bravo     |
            | Carrot    | Cherry | Charlie   |
          Then my tests pass
      """
    When I run `cucumber_lint`
    Then it passes

  Scenario: lowercase - lint and fix
    Given I have "consistent_table_headers" enabled with "enforced_style" as "lowercase"
    When I run `cucumber_lint`
    Then it fails with
      | LINE | MESSAGE                 |
      | 5    | lowercase table headers |
    When I run `cucumber_lint --fix`
    Then my feature now has content
      """
      Feature: Test Feature

        Scenario: Test Scenario
          Given a table
            | vegetable | fruit  | code name |
            | Asparagus | Apple  | Alpha     |
            | Broccoli  | Banana | Bravo     |
            | Carrot    | Cherry | Charlie   |
          Then my tests pass
      """
    When I run `cucumber_lint`
    Then it passes
