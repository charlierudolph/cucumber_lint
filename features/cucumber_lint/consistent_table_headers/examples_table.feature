Feature: consistent_table_headers for an examples table

  Background:
    Given I have a feature with content
      """
      Feature: Test Feature

        Scenario Outline: Test Scenario Outline
          Given <VEGETABLE> and <fruit>
          Then I expect <Code Name>

          Examples:
            | VEGETABLE | fruit  | Code Name |
            | Asparagus | Apple  | Alpha     |
            | Broccoli  | Banana | Bravo     |
            | Carrot    | Cherry | Charlie   |
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
      | 4    | uppercase "<fruit>"     |
      | 5    | uppercase "<Code Name>" |
      | 8    | uppercase table headers |
    When I run `cucumber_lint --fix`
    Then my feature now has content
      """
      Feature: Test Feature

        Scenario Outline: Test Scenario Outline
          Given <VEGETABLE> and <FRUIT>
          Then I expect <CODE NAME>

          Examples:
            | VEGETABLE | FRUIT  | CODE NAME |
            | Asparagus | Apple  | Alpha     |
            | Broccoli  | Banana | Bravo     |
            | Carrot    | Cherry | Charlie   |
      """
    When I run `cucumber_lint`
    Then it passes

  Scenario: lowercase - lint and fix
    Given I have "consistent_table_headers" enabled with "enforced_style" as "lowercase"
    When I run `cucumber_lint`
    Then it fails with
      | LINE | MESSAGE                 |
      | 4    | lowercase "<VEGETABLE>" |
      | 5    | lowercase "<Code Name>" |
      | 8    | lowercase table headers |
    When I run `cucumber_lint --fix`
    Then my feature now has content
      """
      Feature: Test Feature

        Scenario Outline: Test Scenario Outline
          Given <vegetable> and <fruit>
          Then I expect <code name>

          Examples:
            | vegetable | fruit  | code name |
            | Asparagus | Apple  | Alpha     |
            | Broccoli  | Banana | Bravo     |
            | Carrot    | Cherry | Charlie   |
      """
    When I run `cucumber_lint`
    Then it passes
