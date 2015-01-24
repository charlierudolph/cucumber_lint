# cucumber_lint
[![Gem Version](https://badge.fury.io/rb/cucumber_lint.svg)](http://badge.fury.io/rb/cucumber_lint)
[![Build Status](https://travis-ci.org/charlierudolph/cucumber_lint.svg?branch=master)](https://travis-ci.org/charlierudolph/cucumber_lint)
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
Override the [default config](./config/default.yml) by setting the key to one of the supported styles.

```yml
# cucumber_lint.yml
table_headers: lowercase
```

### Features

#### Empty `.feature` files
* Not allowed


#### Repeating step keywords
* Use `And` instead of repeating `Given`, `When`, or `Then`

```coffee
# Bad         # Good
Given A       Given A
Given B       And B
When C        When C
Then D        Then D
Then E        And E
```

#### Table whitespace
* requires leading and trailing space around the cell content
* requires pipes to be aligned


```coffee
# Bad                      # Bad                               # Good
|VEGETABLE|CODENAME|       | VEGETABLE | CODENAME      |       | VEGETABLE | CODENAME |
|Asparagus|Alpha|          |Asparagus | Alpha   |              | Asparagus | Alpha    |
|Broccoli|Bravo|           |Broccoli      | Bravo    |         | Broccoli  | Bravo    |
|Carrot|Charlie|           |  Carrot| Charlie      |           | Carrot    | Charlie  |
```

#### Table headers and scenario outline placeholders
* required to be uppercase by default (configure to require lowercase)
