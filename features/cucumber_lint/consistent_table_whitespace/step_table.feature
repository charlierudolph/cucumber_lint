Feature: consistent_table_whitespace for a step table

  Background:
    Given I have a feature with content
      """
      Feature: Test Feature

        Scenario: Test Scenario
          Given a table
            |VEGETABLE|CODENAME|
            |Asparagus|Alpha|
            |Broccoli|Bravo|
            |Carrot|Charlie|
          Then my tests pass
      """

  Scenario: lint - disabled
    Given I have "consistent_table_whitespace" disabled
    When I run `cucumber_lint`
    Then it passes

  Scenario: lint - enabled
    Given I have "consistent_table_whitespace" enabled
    When I run `cucumber_lint`
    Then it fails with
      | LINE | MESSAGE              |
      | 5    | Fix table whitespace |

  Scenario: fix - enabled
    Given I have "consistent_table_whitespace" enabled
    When I run `cucumber_lint --fix`
    Then my feature now has content
      """
      Feature: Test Feature

        Scenario: Test Scenario
          Given a table
            | VEGETABLE | CODENAME |
            | Asparagus | Alpha    |
            | Broccoli  | Bravo    |
            | Carrot    | Charlie  |
          Then my tests pass
      """
    When I run `cucumber_lint`
    Then it passes
