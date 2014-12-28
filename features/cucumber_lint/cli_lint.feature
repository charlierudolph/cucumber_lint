Feature: cli lint

  Scenario: no files
    Given I have no files
    When I run `cucumber_lint`
    Then I see the output
      """


      0 files inspected (0 passed)
      """
    And it exits with status 0


  Scenario: formatted file
    Given I have a formatted file at "features/formatted.feature"
    When I run `cucumber_lint`
    Then I see the output
      """
      .

      1 file inspected (1 passed)
      """
    And it exits with status 0


  Scenario: unformatted file
    Given I have an unformatted file at "features/unformatted.feature"
    When I run `cucumber_lint`
    Then I see the output
      """
      F

      Files with unformmated tables:
      ./features/unformatted.feature

      1 file inspected (0 passed, 1 failed)
      """
    And it exits with status 1


  Scenario: formatted file and unformatted file
    Given I have an formatted file at "features/formatted.feature"
    And I have an unformatted file at "features/unformatted.feature"
    When I run `cucumber_lint`
    Then I see the output
      """
      .F

      Files with unformmated tables:
      ./features/unformatted.feature

      2 files inspected (1 passed, 1 failed)
      """
    And it exits with status 1
