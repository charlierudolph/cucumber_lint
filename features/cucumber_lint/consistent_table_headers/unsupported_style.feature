Feature: consistent_table_headers enforcing an unsupported style

  Background:
    Given I have "consistent_table_headers" enabled with "enforced_style" as "invalid"

  Scenario: lint
    When I run `cucumber_lint`
    Then I see the output
      """
      consistent_table_headers does not support invalid. Supported: lowercase, uppercase
      """
    And it exits with status 1

  Scenario: fix
    When I run `cucumber_lint --fix`
    Then I see the output
      """
      consistent_table_headers does not support invalid. Supported: lowercase, uppercase
      """
    And it exits with status 1
