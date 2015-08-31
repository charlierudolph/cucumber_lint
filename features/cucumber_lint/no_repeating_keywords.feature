Feature: no_repeating_keywords enabled

  Background:
    Given I have a feature with content
      """
      Feature: Test Feature

        Scenario: Test Scenario
          Given A
          Given B
          When C
          When D
          Then E
          Then F
      """

  Scenario: lint - disabled
    Given I have "no_repeating_keywords" disabled
    When I run `cucumber_lint`
    Then it passes

  Scenario: lint - enabled
    Given I have "no_repeating_keywords" enabled
    When I run `cucumber_lint`
    Then it fails with
      | LINE | MESSAGE                                |
      | 5    | Use "And" instead of repeating "Given" |
      | 7    | Use "And" instead of repeating "When"  |
      | 9    | Use "And" instead of repeating "Then"  |

  Scenario: fix - enabled
    Given I have "no_repeating_keywords" enabled
    When I run `cucumber_lint --fix`
    Then my feature now has content
      """
      Feature: Test Feature

        Scenario: Test Scenario
          Given A
          And B
          When C
          And D
          Then E
          And F
      """
    When I run `cucumber_lint`
    Then it passes
