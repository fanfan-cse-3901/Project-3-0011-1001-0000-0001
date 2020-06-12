# frozen_string_literal: true

# File created 06/10/2020 by Troy Stein

=begin
Main file.
=end

require 'mechanize'
require './org.rb'
require './basic_search.rb'
require './get_org_list.rb'
require './get_org_data.rb'
require './output.rb'

# MAIN
puts 'Welcome to The Ohio State University Clubs page!'
url = basic_search # Call basic_search to trim list of organizations
orgs = [] # orgs - array to store Org objects
get_org_list url, orgs # stores objects into array orgs
get_org_data orgs # populates Org objects with respective data
output_handler orgs # display all Orgs
