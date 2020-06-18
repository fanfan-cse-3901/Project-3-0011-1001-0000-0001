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
* Organization recommendation system: Prachiti Garge
* GUI: Yifan Yao
* HTML output: Amanda Cheng
* Selective attribute display : Kevin Dong
* Volunteer event recommendation system: Troy Stein

#### Testing
* Unit testing module Searching with test plan: Prachiti Garge
* Unit testing output.rb with rspec: Kevin Dong
* Systems Testing:

### How to make to work

#### Step 1: Install Dependencies

```
# Debian/Ubuntu
$ gem install bundler
$ sudo apt install g++ libxrandr-dev libfox-1.6-dev

# macOS
$ gem install bundler
$ brew install g++ fox
$ brew cask install xquartz
```

#### Step 2: Install Gem Packages

```
# Debian/Ubuntu/CentOS
$ bundle install

# macOS
$ sudo bundle install
```

#### :beers: Step 3: Enjoy :beers:

```
# command line interface
$ ruby main.rb

# GUI to scrapping everything via keywords to JSON
# ATTN macOS - run XQuartz before calling ./GUI/gui.rb
$ ruby GUI/gui.rb 
```