Feature: fixing

  Scenario: nothing
    Given I have no files
    When I run `cucumber_lint --fix`
    Then I see the output
      """


      0 files inspected
      """
    And it exits with status 0
