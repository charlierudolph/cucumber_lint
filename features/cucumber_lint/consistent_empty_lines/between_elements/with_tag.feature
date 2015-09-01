Feature: consistent_empty_lines between elements (with tag)

  Background:
    Given I have a feature with content
      """
      Feature: Test Feature

        Scenario: Test Scenario
          Given this
          Then that
        @tag
        Scenario: Test Scenario
          Given this
          Then that
      """

  Scenario: disabled
    Given I have "consistent_empty_lines" disabled
    When I run `cucumber_lint`
    Then it passes

  Scenario: lint and fix
    Given I have "consistent_empty_lines" enabled with
      | KEY              | VALUE |
      | between_elements | 1     |
    When I run `cucumber_lint`
    Then it fails with
      | LINE | MESSAGE        |
      | 6    | Add empty line |
    When I run `cucumber_lint --fix`
    Then my feature now has content
      """
      Feature: Test Feature

        Scenario: Test Scenario
          Given this
          Then that

        @tag
        Scenario: Test Scenario
          Given this
          Then that
      """
    When I run `cucumber_lint`
    Then it passes
