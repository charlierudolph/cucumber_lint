Feature: no_empty_features enabled

  Background:
    Given I have a file without a feature
    And I have no_empty_features enabled


  Scenario: lint
    When I run `cucumber_lint`
    Then I see the output
      """
      F

      ./features/test.feature: Remove file with no feature

      1 file inspected (0 passed, 1 failed)
      """
    And it exits with status 1


  Scenario: fix
    When I run `cucumber_lint --fix`
    Then I see the output
      """
      D

      1 file inspected (0 passed, 1 deleted)
      """
    And it exits with status 0
    And the file has been deleted
