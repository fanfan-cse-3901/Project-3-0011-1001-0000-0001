# frozen_string_literal: true

# File created 06/11/2020 by Yifan Yao: created URL
# Edited 06/11/2020 by Amanda Cheng: Reconstructed entire get_org_data and stored every information into Org Object
# Edited 06/14/2020 by Kevin Dong: get_org_attr method
require 'mechanize'
require './org.rb'

# Public: Process the student organizations by unique identifier, then store data into object.
#
# orgs - array to store Orgs
#
# Returns nothing.
def get_org_data orgs
  print 'PROCCESSING: ['
  orgs.each do |i|
    # construct data into each object via unique identifier
    org_url = "https://activities.osu.edu/involvement/student_organizations/find_a_student_org?i=#{i.id}"

    agent = Mechanize.new
    page = agent.get org_url

    # get values from form via XPath
    name = page.search('//div/h4')
    table = page.search('//form/div/table/tr')
    # store into name object
    i.name = name.text
    count = 0
    while count < table.length
      combo = table[count].text.split(':')
      if combo[0].include? 'Campus'
        i.campus = combo[1].strip
        # puts i.campus
      elsif combo[0].include? 'Status'
        i.status = combo[1].strip
      elsif combo[0].include? 'Purpose'
        i.purpose = combo[1].strip
      elsif combo[0].include? 'Primary Leader'
        i.p_leader = combo[1].strip
      elsif combo[0].include? 'Treas'
        i.t_leader = combo[1].strip
      elsif combo[0].include? 'Advisor'
        i.advisor = combo[1].strip
      elsif combo[0].include? 'Email'
        i.email = combo[1].strip
      elsif combo[0].include? 'Website'
        # Since we split by :, links often have : so we repatch it here
        link_count = 2
        link = combo[1].strip
        while link_count < combo.length
          link += ':' + combo[link_count].strip
          link_count += 1
        end
        i.website = link
      # puts i.website
      elsif combo[0].include? 'Facebook'
        # Since we split by :, links often have : so we repatch it here
        link_count = 2
        link = combo[1].strip
        while link_count < combo.length
          link += ':' + combo[link_count].strip
          link_count += 1
        end
        i.facebook = link
      # puts i.facebook
      elsif combo[0].include? 'Primary Type'
        i.p_type = combo[1].strip
      elsif combo[0].include? 'Secondary Type'
        i.s_type = combo[1].strip
      elsif combo[0].include? 'Make Up'
        i.make_up = combo[1].strip
      elsif combo[0].include? 'Constitution'
        i.constitution = combo[1].strip
      elsif combo[0].include? 'Meeting Time'
        i.time_place = combo[1].strip
      elsif combo[0].include? 'Office Location'
        i.office_location = combo[1].strip
      elsif combo[0].include? 'Membership Type'
        i.membership_type = combo[1].strip
      elsif combo[0].include? 'Membership Contact'
        i.membership_contact = combo[1].strip
      elsif combo[0].include? 'Time of Year'
        i.new_membership_time = combo[1].strip
      elsif combo[0].include? 'How'
        i.how_to_apply = combo[1].strip
      elsif combo[0].include? 'Charge'
        i.charge_dues = combo[1].strip
      end
      count += 1

    end
    print '█'
  end
  print ']'
  puts
end

# Created on 06/13/2020 by Kevin Dong
# Public: Scrapes selected attributes from each org page.
#
# orgs - array of hashes that represent the org
# attr - array of attributes to scrape
#
# Updates orgs with more key-value pairs per org hash
def get_org_attr orgs, attr
  print 'SCRAPING: ['
  orgs.each do |org|
    agent = Mechanize.new
    page = agent.get "https://activities.osu.edu/involvement/student_organizations/find_a_student_org?i=#{org.id}"

    # get values from form via XPath
    name = page.search('//div/h4')
    table = page.search('//form/div/table/tr')

    # store into name object
    org['Name'] = name.text
    (0...table.length).each do |count|
      combo = table[count].text.split(':')
      org[combo[0]] = attr_parse combo, attr
    end
    print '█'
  end
  print ']'
  puts
end

# Created on 06/13/2020 by Kevin Dong
# Internal: Updates attribute if in attr
#
# attr_line - Array containing attribute name and value
# attr - array of attributes
#
# Returns string of value.
def attr_parse attr_line, attr
  if attr_line[0] == 'Facebook' || attr_line == 'Website'
    link = attr_line[1...attr_line.length]
    attr_line[1] = link.reduce { |whole, seg| whole.strip + ':' + seg.strip }
  end
  attr_line[1].strip if attr.include? attr_line[0]
end