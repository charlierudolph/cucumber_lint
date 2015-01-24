Feature: consistent_table_whitespace disabled for an examples table

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
    And I have consistent_table_whitespace disabled


  Scenario: lint
    When I run `cucumber_lint`
    Then I see the output
      """
      .

      1 file inspected (1 passed)
      """
    And it exits with status 0
