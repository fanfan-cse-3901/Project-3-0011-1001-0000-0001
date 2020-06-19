# Project 3
### Web Scraping

### Roles
* Overall Project Manager: Prachiti Garge
* Coding Manager: Amanda Cheng
* Testing Manager: Yifan Yao
* Documentation Manager: Kevin Dong
* Honorable Mention: Troy Stein

### Contributions

#### Core Functionality
* Obtain all search conditions by dynamic scraping: Prachiti Garge
* Scrape list of organizations: Yifan Yao
* Scrape individual organization page: Amanda Cheng
* Output results: Kevin Dong
* Scrape volunteer events: Troy Stein

#### Extra Functionality
* Organization Recommendation System: Prachiti Garge
* GUI: Yifan Yao
* HTML Output: Amanda Cheng
* Selective Attribute Scrape and Display : Kevin Dong
* JSON Output: Troy Stein

* Note: Recommendations can only be obtained when only some (not all) categories are selected.

#### Testing
* Unit testing module Searching with testing/basic_search_test_plan: Prachiti Garge
* Module Recommendations testing with testing/recommendation_test_cases: Prachiti Garge
* Unit testing output.rb with rspec on spec/output_spec.rb: Kevin Dong
* get_org_data.rb testing using rspec spec/get_org_data_spec.rb : Kevin Dong
* get_org_list and GUI testing with testing/gui_test_plan: Yifan Yao
* HTML Output testing with testing/output_html_plan: Amanda Cheng
* Systems Testing with testing/test_plan: Prachiti Garge, Amanda Cheng, Kevin Dong, Yifan Yao

### Setup

#### Step 1: Install Dependencies

```
# Debian/Ubuntu
$ gem install bundler
$ sudo apt install g++ libxrandr-dev libfox-1.6-dev
```

#### Step 2: Install Gem Packages

```
# Debian/Ubuntu
$ bundle install
```

#### :beers: Step 3: Enjoy :beers:

```
# command line interface
$ ruby main.rb

# GUI to scrapping everything via keywords to JSON
$ ruby gui.rb 
```

### The Program

* Run main.rb for console based input with Advanced Search functionality, Attribute filtering.

* Run gui.rb for graphical input with custom information output, graphical file output, and separate organization listing.

* Run rspec test cases using command 'rspec' in the project directory.

* Run other test plans using 'run' in the respective ruby files.