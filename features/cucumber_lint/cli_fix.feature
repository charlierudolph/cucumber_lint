Feature: cli format

  Scenario: no files
    Given I have no files
    When I run `cucumber_lint --fix`
    Then I see the output
      """


      0 files inspected (0 written)
      """
    And it exits with status 0


  Scenario: formatted file
    Given I have a formatted file at "features/formatted.feature"
    When I run `cucumber_lint --fix`
    Then I see the output
      """
      .

      1 file inspected (0 written)
      """
    And it exits with status 0


  Scenario: unformatted file
    Given I have an unformatted file at "features/unformatted.feature"
    When I run `cucumber_lint --fix`
    Then I see the output
      """
      W

      1 file inspected (1 written)
      """
    And it exits with status 0
    And the file "features/unformatted.feature" in now formatted


  Scenario: formatted file and unformatted file
    Given I have an formatted file at "features/formatted.feature"
    And I have an unformatted file at "features/unformatted.feature"
    When I run `cucumber_lint --fix`
    Then I see the output
      """
      .W

      2 files inspected (1 written)
      """
    And it exits with status 0
    And the file "features/unformatted.feature" in now formatted
