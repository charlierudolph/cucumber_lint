Feature: linting

  Scenario: a feature with unformatted repeating steps
    Given I have a feature with unformatted repeating steps
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


  Scenario: a feature with formatted repeating steps
    Given I have a feature with formatted repeating steps
    When I run `cucumber_lint`
    Then I see the output
      """
      .

      1 file inspected (1 passed)
      """
    And it exits with status 0
