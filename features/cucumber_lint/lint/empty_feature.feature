Feature: linting

  Scenario: file with no features
    Given I have a file with no features
    When I run `cucumber_lint`
    Then I see the output
      """
      F

      ./features/test.feature: Remove empty feature

      1 file inspected (0 passed, 1 failed)
      """
    And it exits with status 1
