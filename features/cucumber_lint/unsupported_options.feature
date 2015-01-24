Feature: unsupported option

  Scenario: passing an unsupported option
    When I run `cucumber_lint --invalid`
    Then I see the output
      """
      error: unsupported option(s): --invalid
      usage: cucumber_lint
         or: cucumber_lint --fix
      """
    And it exits with status 1
