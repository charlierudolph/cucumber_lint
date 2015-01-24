Feature: no_repeating_keywords enabled

  Background:
    Given I have a feature with content
      """
      Feature: Test Feature

        Scenario: Test Scenario
          Given A
          Given B
          Given C
          When D
          When E
          When F
          Then G
          Then H
          Then I
      """
    And I have no_repeating_keywords enabled


  Scenario: lint
    When I run `cucumber_lint`
    Then I see the output
      """
      F

      ./features/test.feature:5: Use "And" instead of repeating "Given"
      ./features/test.feature:6: Use "And" instead of repeating "Given"
      ./features/test.feature:8: Use "And" instead of repeating "When"
      ./features/test.feature:9: Use "And" instead of repeating "When"
      ./features/test.feature:11: Use "And" instead of repeating "Then"
      ./features/test.feature:12: Use "And" instead of repeating "Then"

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

        Scenario: Test Scenario
          Given A
          And B
          And C
          When D
          And E
          And F
          Then G
          And H
          And I
      """
