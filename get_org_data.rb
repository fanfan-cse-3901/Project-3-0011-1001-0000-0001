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
    table = page.search('//form/div/table/tr')
    # attributes = page.search('//form/div/table/tr/td')

    #puts table[]
    # sanatize spaces then output
    #  table.each do |j|
    #    puts j.text.split(':') # .join(' ')
    # #   # TODO: put values into object
    #  end
    count = 0
    while count < table.length()
      combo = table[count].text.split(':')
      if combo[0].include? "Campus"
        i.campus = combo[1].strip
        puts i.campus
      elsif combo[0].include? "Status"
        i.status = combo[1].strip
      elsif combo[0].include? "Purpose"
        i.purpose = combo[1].strip
      elsif combo[0].include? "Primary Leader"
        i.p_leader = combo[1].strip
        puts i.p_leader
      elsif combo[0].include? "Treas"
        i.t_leader = combo[1].strip
      elsif combo[0].include? "Advisor"
        i.advisor = combo[1].strip
      elsif combo[0].include? "Email"
        i.email = combo[1].strip
        puts i.email
      elsif combo[0].include? "Website"
        i.website = combo[1].strip
      elsif combo[0].include? "Facebook"
        i.website = combo[1].strip
      end
      count += 1
    end
    # i.campus = table[0].text.split.join(' ')
    # i.status = table[1].text.split.join(' ')
    # i.purpose = table[2].text.split.join(' ')
    # i.p_leader = table[3].text.split.join(' ')
    # i.s_leader = table[4].text.split.join(' ')
    # i.t_leader = table[5].text.split.join(' ')
    # i.advisor = table[6].text.split.join(' ')
    # i.email = table[7].text.split.join(' ')
    # i.website = table[8].text.split.join(' ')
    # i.p_type = table[9].text.split.join(' ')
    # i.s_type = table[10].text.split.join(' ')
    # if table[11].text != nil
    #   i.make_up = table[11].text.split.join(' ')
    #   #puts i.make_up
    # end
    #
    # i.constitution = table[12].text.split.join(' ')
    # i.time_place = table[13].text.split.join(' ')
    # i.office_location = table[14].text.split.join(' ')
    # i.membership_type = table[15].text.split.join(' ')
    # i.membership_contact = table[16].text.split.join(' ')
    # i.new_membership_time = table[17].text.split.join(' ')
    # i.how_to_apply = table[18].text.split.join(' ')
    # if table[19].text != nil
    #   i.charge_dues = table[19].text.split.join(' ')
    #   #puts i.charge_dues
    # end

    #puts i.make_up
  end
end
