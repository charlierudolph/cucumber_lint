Feature: consistent_table_whitespace for an examples table

  Background:
    Given I have a feature with content
      """
      Feature: Test Feature

        Scenario Outline: Test Scenario Outline
          Given <VEGETABLE> and <FRUIT>
          Then I expect <CODENAME>

          Examples:
            |VEGETABLE| FRUIT  |    CODENAME   |
            |Asparagus | Apple     | Alpha    |
            |Broccoli  | Banana |  Bravo    |
            | Carrot|   Cherry |   Charlie  |
      """

  Scenario: disabled
    Given I have "consistent_table_whitespace" enabled
    When I run `cucumber_lint --fix`
    Then it passes

  Scenario: lint and fix
    Given I have "consistent_table_whitespace" enabled
    When I run `cucumber_lint`
    Then it fails with
      | LINE | MESSAGE              |
      | 8    | Fix table whitespace |
    When I run `cucumber_lint --fix`
    Then my feature now has content
      """
      Feature: Test Feature

        Scenario Outline: Test Scenario Outline
          Given <VEGETABLE> and <FRUIT>
          Then I expect <CODENAME>

          Examples:
            | VEGETABLE | FRUIT  | CODENAME |
            | Asparagus | Apple  | Alpha    |
            | Broccoli  | Banana | Bravo    |
            | Carrot    | Cherry | Charlie  |
      """
    When I run `cucumber_lint`
    Then it passes
