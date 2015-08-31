Feature: no_empty_features

  Background:
    Given I have a file without a feature

  Scenario: lint - disabled
    Given I have "no_empty_features" disabled
    When I run `cucumber_lint`
    Then it passes

  Scenario: lint - enabled
    Given I have "no_empty_features" enabled
    When I run `cucumber_lint`
    Then it fails with
      | MESSAGE                     |
      | Remove file with no feature |

  Scenario: fix - enabled
    Given I have "no_empty_features" enabled
    When I run `cucumber_lint --fix`
    Then the file has been deleted
    When I run `cucumber_lint`
    Then it passes
