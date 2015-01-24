Feature: consistent_table_headers enforcing uppercase for an examples table

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
    And I have consistent_table_headers enforcing uppercase


  Scenario: lint
    When I run `cucumber_lint`
    Then I see the output
      """
      F

      ./features/test.feature:4: uppercase "<fruit>"
      ./features/test.feature:5: uppercase "<Code Name>"
      ./features/test.feature:8: uppercase table headers

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

        Scenario Outline: Test Scenario Outline
          Given <VEGETABLE> and <FRUIT>
          Then I expect <CODE NAME>

          Examples:
            | VEGETABLE | FRUIT  | CODE NAME |
            | Asparagus | Apple  | Alpha     |
            | Broccoli  | Banana | Bravo     |
            | Carrot    | Cherry | Charlie   |
      """
