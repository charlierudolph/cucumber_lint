Feature: no files

  Scenario: lint
    Given I have no files
    When I run `cucumber_lint`
    Then it passes
