# frozen_string_literal: true

# File created on 06/10/2020 by Yifan Yao
require 'mechanize'
require './org.rb'

# Edited on 06/13/2020 by Amanda Cheng: hash instead of org class
# Edited on 06/14/2020 by Kevin Dong: fixed missing hash features
# Public: Process the list of student organizations by specific url, then create objects and stored into an array.
#
# request_url - url of the list student organizations
# orgs - array to store Orgs
#
# Updates orgs array.
def get_org_list request_url, orgs
  agent = Mechanize.new
  # scraping from 'https://activities.osu.edu/involvement/student_organizations/find_a_student_org?v=list&c=Columbus'
  page = agent.get request_url

  # output workload
  puts page.search('//form/div/h3').text.split.join(' ')

  page.links.each do |link|
    # construct url via current_id:
    # org_url = "https://activities.osu.edu/involvement/student_organizations/find_a_student_org?i=#{current_id}"
    current_id = /[a-z0-9]{8}-[a-z0-9]{4}-[a-z0-9]{4}-[a-z0-9]{4}-[a-z0-9]{12}/.match(link.href).to_s
    org = Hash.new { |h, k| h[k] = 'N/A' }
    org['id'] = current_id
    org['Types'] = []
    orgs << org unless current_id.empty?
  end
end
