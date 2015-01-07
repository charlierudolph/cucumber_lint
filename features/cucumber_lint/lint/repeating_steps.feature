Feature: linting

  Scenario: a feature with repeating steps
    Given I have a feature with repeating steps
    When I run `cucumber_lint`
    Then I see the output
      """
      F

      ./features/repeating_steps.feature:5: Use "And" instead of repeating "Given"
      ./features/repeating_steps.feature:6: Use "And" instead of repeating "Given"
      ./features/repeating_steps.feature:8: Use "And" instead of repeating "When"
      ./features/repeating_steps.feature:9: Use "And" instead of repeating "When"
      ./features/repeating_steps.feature:11: Use "And" instead of repeating "Then"
      ./features/repeating_steps.feature:12: Use "And" instead of repeating "Then"

      1 file inspected (0 passed, 1 failed)
      """
    And it exits with status 1


  Scenario: a feature with formatted repeating steps
    Given I have a feature with formatted repeating steps
    When I run `cucumber_lint`
    Then I see the output
      """
      .

      1 file inspected (1 passed)
      """
    And it exits with status 0
