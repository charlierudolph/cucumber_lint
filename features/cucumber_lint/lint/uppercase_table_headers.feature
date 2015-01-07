Feature: fixing

  Scenario: a feature with unformatted uppercase table headers
    Given I have a feature with unformatted uppercase table headers
    When I run `cucumber_lint`
    Then I see the output
      """
      F

      ./features/uppercase_table_headers.feature:5: Make table headers uppercase
      ./features/uppercase_table_headers.feature:13: Make "<vegetable>" uppercase
      ./features/uppercase_table_headers.feature:13: Make "<fruit>" uppercase
      ./features/uppercase_table_headers.feature:14: Make "<codename>" uppercase
      ./features/uppercase_table_headers.feature:17: Make table headers uppercase

      1 file inspected (0 passed, 1 failed)
      """
    And it exits with status 1


  Scenario: a feature with formatted uppercase table headers
    Given I have a feature with formatted uppercase table headers
    When I run `cucumber_lint`
    Then I see the output
      """
      .

      1 file inspected (1 passed)
      """
    And it exits with status 0
