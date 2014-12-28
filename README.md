# cucumber_lint
[![Dependency Status](https://gemnasium.com/charlierudolph/cucumber_lint.svg)](https://gemnasium.com/charlierudolph/cucumber_lint)
[![Code Climate](https://codeclimate.com/github/charlierudolph/cucumber_lint/badges/gpa.svg)](https://codeclimate.com/github/charlierudolph/cucumber_lint)

A command line linter and formatter for cucumber features

### Installation

```
gem install cucumber_lint
```

### Usage

```
cucumber_lint        # Lints (exits with status 1 on failure, 0 on success)
cucumber_lint --fix  # Fixes all lint errors
```

### Tables
* requires at a space leading and trailing cell content
* requires pipes to be aligned

Bad
````
|header_column1|header_column2|
|row1_column1|row1_column2|
|row2_column1|row2_column2|
|row3_column1|row3_column2|
```
Bad
```
| header_column1 | header_column2      |
| row1_column1 | row1_column2           |
| row2_column1      | row2_column2    |
  | row3_column1 | row3_column2      |
```
Good
```
| header_column1 | header_column2 |
| row1_column1   | row1_column2   |
| row2_column1   | row2_column2   |
| row3_column1   | row3_column2   |
```

### Steps
* Use `And` instead of repeating `Given`, `When`, or `Then`

Bad
```
Given A
Given B
When C
Then D
Then E
```
Good
```
Given A
And B
When C
Then D
And E
```
