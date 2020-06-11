# frozen_string_literal: true

# File created 06/11/2020 by Yifan Yao
require 'mechanize'
require './org.rb'

# Public: Process the student organizations by unique identifier, then store data into object.
#
# orgs - array to store Orgs
#
# Returns nothing.
def get_org_data orgs
  orgs.each do |i|
    # construct data into each object via unique identifier
    org_url = "https://activities.osu.edu/involvement/student_organizations/find_a_student_org?i=#{i.id}"

    agent = Mechanize.new
    page = agent.get org_url

    # get values from form via XPath
    table = page.search('//form/div/table/tr/td')

    # sanatize spaces then output
    table.each do |i|
      puts i.text.split.join(' ')
      # TODO: put values into object
    end
  end
end
