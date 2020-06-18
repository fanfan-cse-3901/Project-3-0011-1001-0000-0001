# frozen_string_literal: true

# This module performs the searches to trim the list of student organizations.
# Has method basic_search.
# Created on 06/10/2020 by Prachiti Garge
# Edited on 06/12/2020 by Prachiti Garge: Added mechanize
# Edited on 06/14/2020 by Prachiti Garge: Added method to get list of attributes
# Edited on 06/17/2020 by Prachiti Garge:Added comments Debugged
# DO NOT FIX ALL OFFENCES ON THIS PAGE DIRECTLY

require 'mechanize'
require 'cgi'

# Module Searching has all the methods that get user requirements for showing organizations
module Searching
  # @return url to the first page of searches
  # Created on 06/10/2020 by Prachiti Garge
  # Edited on 06/12/2020 by Prachiti Garge: Used mechanize and regex
  # Edited on 06/17/2020 by Prachiti Garge: Added comments
  def self.basic_search
    # Get page from mechanize
    agent = Mechanize.new
    page = agent.get 'https://activities.osu.edu/involvement/student_organizations/find_a_student_org/?v=list'

    # Get basic search criteria
    val = 'https://activities.osu.edu/involvement/student_organizations/find_a_student_org/?v=list' + Searching.get_campus(page) +
          Searching.get_directory + Searching.get_search

    # Ask for advanced search
    print 'Do you want to perform advanced search? (y/n): '
    input = gets.chomp
    puts

    # Check for correct input
    while !/^[ynYN]$/.match? input
      print 'Invalid input! Do you want to perform advanced search? (y/n): '
      input = gets.chomp
      puts
    end

    # Get advanced search criteria if yes
    val += Searching.get_category(page) + Searching.get_text_type(page) + Searching.get_reg_win(page) + Searching.show_inactive_org if /[yY]/.match? input

    # Get list of attributes, 21 if all
    arr = Searching.att_getter

    # Form and return array
    ret_arr = Array[val, arr]
    ret_arr
  end

  # Asks user for campus and returns addition to url
  # Created on 06/10/2020 by Prachiti Garge
  # Edited on 06/12/2020 by Prachiti Garge: Used mechanize and regex
  # Edited on 06/17/2020 by Prachiti Garge: Added comments and debugged
  def self.get_campus(page)

    # Scrape the page for campus list
    ret = ''
    list = page.search '//div/select/option'
    campuses = []

    # List elements pushed to array
    list.each do |i|
      campuses.push i.text.split.join(' ')
    end

    # Display list of campuses to user
    (0...campuses.length).each do |i|
      puts "#{i + 1}: #{campuses[i]}"
    end

    # Get user input
    print "Enter a number between 1 and #{campuses.length} for a campus: "
    input = gets.chomp
    puts

    # Check input for validity
    while (!/^[1-9][0-9]*$/.match? input) || input.to_i > campuses.length
      print "Invalid input! Enter a number between 1 and #{campuses.length}: "
      input = gets.chomp
      puts
    end

    # Form string and return
    campuses[input.to_i-1] = campuses[input.to_i-1].downcase if campuses[input.to_i-1].downcase == 'all'
    ret = "&c=#{campuses[input.to_i - 1]}"
    ret
  end

  # Asks user for directory and returns addition to url
  # Created on 06/10/2020 by Prachiti Garge
  # Edited on 06/12/2020 by Prachiti Garge: Used mechanize and regex
  # Edited on 06/17/2020 by Prachiti Garge: Added comments
  def self.get_directory
    # Ask user for directory
    print 'Enter an alphabet (1 for numbers, 0 for all) to search directory: '
    input = gets.chomp
    puts

    # Check for validity
    while !/^[A-Za-z01]$/.match? input
      print 'Invalid input! Enter an alphabet (1 for numbers, 0 for all) to search directory: '
      input = gets.chomp
      puts
    end

    # Match user input to corresponding attachment to url and return
    ret = if input == '0'
            '&l=ALL'
          elsif input == '1'
            '&l=1'
          else
            "&l=#{input.capitalize}"
          end
    ret
  end

  # Asks user for search term and returns addition to url
  # Created on 06/10/2020 by Prachiti Garge
  # Edited on 06/12/2020 by Prachiti Garge: Used mechanize and regex
  # Edited on 06/17/2020 by Prachiti Garge: Added comments and debugged
  def self.get_search
    # Get user input
    print 'Type a search term (press enter to skip): '
    input = gets.chomp
    puts

    # Only attach to url if not empty
    ret = ''
    ret = "&s=#{CGI.escape input}" if input != ''
    ret
  end

  # Asks user for categories and returns addition to url
  # Can have multiple categories
  # Created on 06/10/2020 by Prachiti Garge
  # Edited on 06/12/2020 by Prachiti Garge: Used mechanize and regex
  # Edited on 06/17/2020 by Prachiti Garge: Added comments and debugged
  def self.get_category page
    # Scrape the categories
    ret = ''
    list = page.search '//div/span[@id="ctl00_ContentBody_pageFormControl_cbl_org_make_up"]/label'
    categories = []

    # Push categories to array
    list.each do |i|
      categories.push i.text.split.join(' ')
    end

    # Display categories
    (0...categories.length).each do |i|
      puts "#{i + 1}: #{categories[i]}"
    end
    input = []
    input_val = ''

    # Get user input
    while input_val != '-1' # && input_val != '0'
      print "Enter a number between 1 and #{categories.length} per line for a category (0 for all, -1 to end category selection): "
      input_val = gets.chomp
      puts

      # breaks and gives empty string
      break if input_val == '0'

      # Check input validity
      # Extra parenthesis necessary to get correct logic
      while !(((/^[1-9][0-9]*$/.match? input_val) && input_val.to_i <= categories.length) || input_val == '-1' || input_val == '0')
        print "Invalid input! Enter a number between 1 and #{categories.length}: "
        input_val = gets.chomp
        puts
      end
      break if input_val == '0'
      break if input_val == '-1'

      # Push category number onto input
      input.push input_val
    end

    # Checks if need all categories
    unless input.length.zero?
      input.uniq!

      # Turn input into array of integers
      (0...input.length).each do |i|
        input[i] = input[i].to_i
      end
      input.sort!

      # Create proper url if doesn't include 0
      unless input.include? '0'
        ret = "&m=#{CGI.escape(categories[input[0].to_i - 1])}"
        (1...input.length).each do |i|
          ret += "+#{CGI.escape(categories[input[i].to_i - 1])}"
        end
      end
    end
    ret
  end

  # Asks user for text type and returns addition to url
  # Created on 06/10/2020 by Prachiti Garge
  # Edited on 06/12/2020 by Prachiti Garge: Used mechanize and regex
  # Edited on 06/17/2020 by Prachiti Garge: Added comments and debugged
  def self.get_text_type(page)
    # Find options for text type
    ret = ''
    list = page.search '//div/span[@id="ctl00_ContentBody_pageFormControl_rbl_search_type"]/label'
    types = []

    # Push options in the types array
    list.each do |i|
      types.push i.text.split.join(' ')
    end

    # Display options to user
    (0...types.length).each do |i|
      puts "#{i + 1}: #{types[i]}"
    end

    # Get user input
    print "Enter a number between 1 and #{types.length} for searching text type: "
    input = gets.chomp
    puts

    # Check input validity
    while (!/^[1-9][0-9]*$/.match? input) || input.to_i > types.length
      print "Invalid input! Enter a number between 1 and #{types.length}: "
      input = gets.chomp
      puts
    end

    # Attach to string in lower case and return
    ret = "&t=#{types[input.to_i - 1].downcase}"
    ret
  end

  # Asks user for registration window and returns addition to url
  # Created on 06/10/2020 by Prachiti Garge
  # Edited on 06/12/2020 by Prachiti Garge: Used mechanize and regex
  # Edited on 06/17/2020 by Prachiti Garge: Added comments and debugged
  def self.get_reg_win(page)
    # Get option list
    ret = ''
    list = page.search '//div/span[@id="ctl00_ContentBody_pageFormControl_rbl_ott"]/label'
    win = []

    # Push options to win array
    list.each { |i| win.push i.text.split.join ' ' }

    # Display options to user
    (0...win.length).each { |i|
      puts "#{i + 1}: #{win[i]}"
    }

    # Get user input
    print "Enter a number between 1 and #{win.length} for a registration window: "
    input = gets.chomp
    puts

    # Check input validity
    while (!/^[1-9][0-9]*$/.match? input) || input.to_i > win.length
      print "Invalid input! Enter a number between 1 and #{win.length}: "
      input = gets.chomp
      puts
    end

    # Attach to string and return
    ret = "&ot=#{input.to_i - 1}"
    ret
  end

  # Asks user if they want to see inactive clubs and returns addition to url
  # Created on 06/10/2020 by Prachiti Garge
  # Edited on 06/12/2020 by Prachiti Garge: Used mechanize and regex
  # Edited on 06/17/2020 by Prachiti Garge: Added comments
  def self.show_inactive_org
    # Get user input
    ret = ''
    print 'Do you want to see inactive organizations? (y/n): '
    input = gets.chomp
    puts

    # Check input validity
    while !/^[ynYN]$/.match? input
      print 'Invalid input! Do you want to see inactive organizations? (y/n): '
      input = gets.chomp
      puts
    end

    # Attach corresponding url
    ret = if /[yY]/.match? input
            '&a=0'
          else
            '&a=1'
          end
    ret
  end

  # Asks user for the attributes they want to see
  # Created on 06/14/2020 by Prachiti Garge
  # Edited on 06/17/2020 by Prachiti Garge: Added comments and debugged
  def self.att_getter
    # Define list of attributes
    list = Array['Campus', 'Status', 'Purpose Statement', 'Primary Leader', 'Secondary Leader', 'Treasurer Leader',
                 'Advisor', 'Organization Email', 'Facebook Group Page', 'Website', 'Primary Type', 'Secondary Types',
                 'Primary Make Up', 'Constitution', 'Meeting Time and Place', 'Office Location', 'Membership Type',
                 'Membership Contact', 'Time of Year for New Membership', 'How does a Prospective Member Apply',
                 'Charge Dues']
    arr = []

    # Display list of attributes
    (0...list.length).each do |a|
      puts "#{a + 1}: #{list[a]}"
    end

    input = ''

    # break statement ensures loop stops
    while input != '-1'

      # Get user input
      print 'Enter a respective attribute number per line (0 for all, -1 to end selection): '
      input = gets.chomp
      puts

      # Check input validity
      while !(((/^[1-9][0-9]*$/.match? input) && input.to_i <= list.length) || input == '-1' || input == '0')
        print 'Invalid input. Enter number from the range: '
        input = gets.chomp
        puts
      end

      # If zero, breaks out of both loops and assigns all attributes to arr
      if input == '0'
        arr = list
        break
      end

      # Makes sure that -1 is not pushed into arr
      break if /^-1$/.match? input

      # Push attribute into arr
      arr.push list[input.to_i-1]
    end

    # Make unique and return arr
    arr.uniq!
    arr
  end

end