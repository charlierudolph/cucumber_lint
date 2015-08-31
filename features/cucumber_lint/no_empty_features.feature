Feature: no_empty_features

  Background:
    Given I have a file without a feature

  Scenario: disabled
    Given I have "no_empty_features" disabled
    When I run `cucumber_lint`
    Then it passes

  Scenario: lint and fix
    Given I have "no_empty_features" enabled
    When I run `cucumber_lint`
    Then it fails with
      | MESSAGE                     |
      | Remove file with no feature |
    When I run `cucumber_lint --fix`
    Then the file has been deleted
    When I run `cucumber_lint`
    Then it passes
