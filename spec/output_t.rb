# frozen_string_literal: true

# Created on 06/14/2020 by Kevin Dong
# I/O tests
require 'mechanize'
require './lib/basic_search.rb'
require './lib/get_org_list.rb'
require './lib/get_org_data.rb'
require './lib/output.rb'

# should function normally without extra data
def simple
  url = 'https://activities.osu.edu/involvement/student_organizations/find_a_student_org?v=list&l=W&c=Columbus'
  orgs = []
  get_org_list url, orgs
  output_handler orgs, [], url
end


# Run Tests
simple