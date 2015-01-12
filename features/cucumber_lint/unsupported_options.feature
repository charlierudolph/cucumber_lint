Feature: unsupported option

  Scenario: one unsupported option
    When I run `cucumber_lint --invalid`
    Then I see the output
      """
      error: unsupported option(s): --invalid
      usage: cucumber_lint
         or: cucumber_lint --fix
      """
    And it exits with status 1
