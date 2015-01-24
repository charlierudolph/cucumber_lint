Feature: fixing

  Scenario: file with no features
    Given I have a file with no features
    When I run `cucumber_lint --fix`
    Then I see the output
      """
      D

      1 file inspected (0 passed, 1 deleted)
      """
    And it exits with status 0
    And the file has been deleted
