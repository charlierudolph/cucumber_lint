Feature: consistent_table_headers enforcing lowercase for an examples table

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
    And I have consistent_table_headers enforcing lowercase


  Scenario: lint
    When I run `cucumber_lint`
    Then I see the output
      """
      F

      ./features/test.feature:4: lowercase "<VEGETABLE>"
      ./features/test.feature:5: lowercase "<Code Name>"
      ./features/test.feature:8: lowercase table headers

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
          Given <vegetable> and <fruit>
          Then I expect <code name>

          Examples:
            | vegetable | fruit  | code name |
            | Asparagus | Apple  | Alpha     |
            | Broccoli  | Banana | Bravo     |
            | Carrot    | Cherry | Charlie   |
      """
