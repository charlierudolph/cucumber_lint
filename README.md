# cucumber_lint
[![Gem Version](https://badge.fury.io/rb/cucumber_lint.svg)](http://badge.fury.io/rb/cucumber_lint)
[![Circle CI](https://circleci.com/gh/charlierudolph/cucumber_lint/tree/master.svg?style=shield)](https://circleci.com/gh/charlierudolph/cucumber_lint)
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

### Configuration

Create a `cucumber_lint.yml` file in the same folder that contains your `features` directory.
Override the [default config](./config/default.yml) to disable a rule or change the enforced style.

### Rules

##### consistent_empty_lines
* requires empty lines to be used consistently throughout features


##### consistent_table_headers
* requires all table headers to have the same style
  * supported styles: uppercase and lowercase
  * scenario outline placeholders must share the same style


##### consistent_table_whitespace
* requires leading and trailing space around the cell content and the pipes to be aligned


  ```coffee
  # Bad                    # Bad                           # Good
  |VEGETABLE|CODENAME|     | VEGETABLE | CODENAME   |      | VEGETABLE | CODENAME |
  |Asparagus|Alpha|        |Asparagus | Alpha   |          | Asparagus | Alpha    |
  |Broccoli|Bravo|         |Broccoli      | Bravo    |     | Broccoli  | Bravo    |
  |Carrot|Charlie|         |  Carrot| Charlie      |       | Carrot    | Charlie  |
  ```


##### no_repeating_keywords
* Use `And` instead of repeating `Given`, `When`, or `Then`


  ```coffee
  # Bad         # Good
  Given A       Given A
  Given B       And B
  When C        When C
  When D        And D
  Then E        Then E
  Then F        And F
  ```
