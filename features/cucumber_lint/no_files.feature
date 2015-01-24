Feature: no files

  Background:
    Given I have no files

  Scenario: lint
    When I run `cucumber_lint`
    Then I see the output
      """


      0 files inspected
      """
    And it exits with status 0


  Scenario: fix
    Given I have no files
    When I run `cucumber_lint --fix`
    Then I see the output
      """


      0 files inspected
      """
    And it exits with status 0
