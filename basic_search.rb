# frozen_string_literal: true

# This module performs the searches to trim the list of student organizations.
# Has method basic_search.
# Created on 06/10/2020 by Prachiti Garge
# Edited on 06/12/2020 by Prachiti Garge: Added mechanize
# Edited on 06/14/2020 by Prachiti Garge: Added method to get list of attributes
# DO NOT FIX ALL OFFENCES ON THIS PAGE DIRECTLY

require 'mechanize'
require 'cgi'

# Module Searching has all the methods that get user requirements for showing organizations
module Searching
  # @return url to the first page of searches
  # Created on 06/10/2020 by Prachiti Garge
  # Edited on 06/12/2020 by Prachiti Garge: Used mechanize and regex
  def self.basic_search
    agent = Mechanize.new
    page = agent.get 'https://activities.osu.edu/involvement/student_organizations/find_a_student_org/?v=list'
    val = 'https://activities.osu.edu/involvement/student_organizations/find_a_student_org/?v=list' + Searching.get_campus(page) +
          Searching.get_directory + Searching.get_search
    print 'Do you want to perform advanced search? (y/n): '
    input = gets.chomp
    puts
    while !/^[ynYN]$/.match? input
      print 'Invalid input! Do you want to perform advanced search? (y/n): '
      input = gets.chomp
      puts
    end
    val += Searching.get_category(page) + Searching.get_text_type(page) + Searching.get_reg_win(page) + Searching.show_inactive_org if /[yY]/.match? input
    arr = Searching.att_getter
    ret_arr = Array[val, arr]
    ret_arr
  end

  # Asks user for campus and returns addition to url
  # Created on 06/10/2020 by Prachiti Garge
  # Edited on 06/12/2020 by Prachiti Garge: Used mechanize and regex
  def self.get_campus(page)
    ret = ''
    list = page.search '//div/select/option'
    campuses = []
    list.each do |i|
      campuses.push i.text.split.join(' ')
    end
    (0...campuses.length).each do |i|
      puts "#{i + 1}: #{campuses[i]}"
    end
    print "Enter a number between 1 and #{campuses.length} for a campus: "
    input = gets.chomp
    puts
    while (!/^[1-9][0-9]*$/.match? input) && input.to_i >= campuses.length
      print "Invalid input! Enter a number between 1 and #{campuses.length}: "
      input = gets.chomp
      puts
    end
    ret = "&c=#{campuses[input.to_i - 1]}"
    ret
  end

  # Asks user for directory and returns addition to url
  # Created on 06/10/2020 by Prachiti Garge
  # Edited on 06/12/2020 by Prachiti Garge: Used mechanize and regex
  def self.get_directory
    print 'Enter an alphabet (1 for numbers, 0 for all) to search directory: '
    input = gets.chomp
    puts
    while !/^[A-Za-z01]$/.match? input
      print 'Invalid input! Enter an alphabet (1 for numbers, 0 for all) to search directory: '
      input = gets.chomp
      puts
    end
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
  def self.get_search
    print 'Type a search term (press enter to skip): '
    input = gets
    puts
    ret = ''
    ret = "&s=#{CGI.escape input.chomp}" if input != '\n'
    ret
  end

  # Asks user for categories and returns addition to url
  # Can have multiple categories
  # Created on 06/10/2020 by Prachiti Garge
  # Edited on 06/12/2020 by Prachiti Garge: Used mechanize and regex
  def self.get_category page
    ret = ''
    list = page.search '//div/span[@id="ctl00_ContentBody_pageFormControl_cbl_org_make_up"]/label'
    categories = []
    list.each do |i|
      categories.push i.text.split.join(' ')
    end
    (0...categories.length).each do |i|
      puts "#{i + 1}: #{categories[i]}"
    end
    input = []
    input_val = ''
    while input_val != '-1'
      print "Enter a number between 1 and #{categories.length} per line for a category (0 for all, -1 to end category selection): "
      input_val = gets.chomp
      puts
      if ((!/^[1-9][0-9]*$/.match? input_val) || input_val.to_i > categories.length) || (!/^-1$/.match? input_val)
        print "Invalid input! Enter a number between 1 and #{categories.length}: "
        input_val = gets.chomp
        puts
        break if input_val == '0'

      end
      break if input_val == '0'

      input.push input_val
    end
    input.delete('-1')
    unless input.length.zero?
      input.uniq!
      (0...input.length).each do |i|
        input[i] = input[i].to_i
      end
      input.sort!
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
  def self.get_text_type(page)
    ret = ''
    list = page.search '//div/span[@id="ctl00_ContentBody_pageFormControl_rbl_search_type"]/label'
    types = []
    list.each do |i|
      types.push i.text.split.join(' ')
    end
    (0...types.length).each do |i|
      puts "#{i + 1}: #{types[i]}"
    end
    print "Enter a number between 1 and #{types.length} for searching text type: "
    input = gets.chomp
    puts
    while (!/^[1-9][0-9]*$/.match? input) || input.to_i >= types.length
      print "Invalid input! Enter a number between 1 and #{types.length}: "
      input = gets.chomp
      puts
    end
    ret = "&t=#{types[input.to_i - 1].downcase}"
    ret
  end

  # Asks user for registration window and returns addition to url
  # Created on 06/10/2020 by Prachiti Garge
  # Edited on 06/12/2020 by Prachiti Garge: Used mechanize and regex
  def self.get_reg_win(page)
    ret = ''
    list = page.search '//div/span[@id="ctl00_ContentBody_pageFormControl_rbl_ott"]/label'
    win = []
    list.each { |i| win.push i.text.split.join ' ' }
    (0...win.length).each { |i|
      puts "#{i + 1}: #{win[i]}"
    }
    print "Enter a number between 1 and #{win.length} for a registration window: "
    input = gets.chomp
    puts
    while (!/^[1-9][0-9]*$/.match? input)|| input.to_i >= win.length
      print 'Invalid input! Enter a number between 1 and 7: '
      input = gets.chomp
      puts
    end
    ret = "&ot=#{input.to_i - 1}"
    ret
  end

  # Asks user if they want to see inactive clubs and returns addition to url
  # Created on 06/10/2020 by Prachiti Garge
  # Edited on 06/12/2020 by Prachiti Garge: Used mechanize and regex
  def self.show_inactive_org
    ret = ''
    print 'Do you want to see inactive organizations? (y/n): '
    input = gets.chomp
    puts
    while !/^[ynYN]$/.match? input
      print 'Invalid input! Do you want to see inactive organizations? (y/n): '
      input = gets.chomp
      puts
    end
    ret = if /[yY]/.match? input
            '&a=0'
          else
            '&a=1'
          end
    ret
  end

  # Asks user for the attributes they want to see
  # Created on 06/14/2020 by Prachiti Garge
  def self.att_getter
    list = Array['Campus', 'Status', 'Purpose Statement', 'Primary Leader', 'Secondary Leader', 'Treasurer Leader',
                 'Advisor', 'Organization Email', 'Facebook Group Page', 'Website', 'Primary Type', 'Secondary Types',
                 'Primary Make Up', 'Constitution', 'Meeting Time and Place', 'Office Location', 'Membership Type',
                 'Membership Contact', 'Time of Year for New Membership', 'How does a Prospective Member Apply',
                 'Charge Dues']
    arr = []
    (0...list.length).each do |a|
      puts "#{a + 1}: #{list[a]}"
    end
    input = ''
    while input != '-1'
      print 'Enter a respective attribute number per line (-1 to end selection): '
      input = gets.chomp
      puts
      if (!/^[1-9][0-9]*$/.match? input) || input.to_i > list.length || (!/^-1$/.match? input)
        print 'Invalid input. Enter number from the range: '
        input = gets.chomp
        puts
      end
      break if /^-1$/.match? input

      arr.push list[input.to_i-1]
    end
    arr
  end
end

agent = Mechanize.new
page = agent.get 'https://activities.osu.edu/involvement/student_organizations/find_a_student_org/?v=list'
puts Searching.get_category page