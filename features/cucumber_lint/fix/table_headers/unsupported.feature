Feature: fixing

  Scenario: unsupported table_headers style
    Given I have configured table_headers to enforce unsupported_style
    When I run `cucumber_lint --fix`
    Then I see the output
      """
      table_headers does not support unsupported_style. Supported: lowercase, uppercase
      """
    And it exits with status 1
