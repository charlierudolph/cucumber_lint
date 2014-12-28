Feature: table formatter

  Scenario: minimal table
    Given table lines
      """
      |header_column1|header_column2|
      |row1_column1|row1_column2|
      |row2_column1|row2_column2|
      |row3_column1|row3_column2|
      """
    Then the formatted table lines are
      """
      | header_column1 | header_column2 |
      | row1_column1   | row1_column2   |
      | row2_column1   | row2_column2   |
      | row3_column1   | row3_column2   |
      """


  Scenario: misaligned spacing in table
    Given table lines
      """
      | header_column1 | header_column2      |
      | row1_column1 | row1_column2           |
      | row2_column1      | row2_column2    |
      | row3_column1 | row3_column2      |
      """
    Then the formatted table lines are
      """
      | header_column1 | header_column2 |
      | row1_column1   | row1_column2   |
      | row2_column1   | row2_column2   |
      | row3_column1   | row3_column2   |
      """


  Scenario: formatted table
    Given table lines
      """
      | header_column1 | header_column2 |
      | row1_column1   | row1_column2   |
      | row2_column1   | row2_column2   |
      | row3_column1   | row3_column2   |
      """
    Then the table is formatted
