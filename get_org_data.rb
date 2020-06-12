# frozen_string_literal: true

# File created 06/11/2020 by Yifan Yao: created URL
# Edited 06/11/2020 by Amanda Cheng: Reconstructed entire get_org_data and stored every information into Org Object
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
    name = page.search('//div/h4')
    table = page.search('//form/div/table/tr')
    # store into name object
    i.name = name.text

    count = 0
    while count < table.length()
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
        while link_count < combo.length()
          link += ':' + combo[link_count].strip
          link_count += 1
        end
        i.website = link
         # puts i.website
      elsif combo[0].include? 'Facebook'
        # Since we split by :, links often have : so we repatch it here
        link_count = 2
        link = combo[1].strip
        while link_count < combo.length()
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
  end
end
