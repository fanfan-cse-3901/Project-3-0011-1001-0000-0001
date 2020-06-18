# frozen_string_literal: true

# File created 06/11/2020 by Yifan Yao: created URL
# Edited 06/11/2020 by Amanda Cheng: get_org_data method
# Edited 06/14/2020 by Kevin Dong: get_org_attr method
# Edited 06/15/2020 by Kevin Dong: get_org_data method edit
require 'mechanize'

# Created on 06/11/2020 by Yifan Yao
# Edited on 06/11/2020 by Amanda Cheng: Reconstructed entire get_org_data and stored every information into Org Object
# Edited on 06/11/2020 by Kevin Dong: Hash adjustments
# Public: Process the student organizations by unique identifier, then store data into object.
#
# orgs - array to store Orgs
#
# Returns nothing.
def get_org_data orgs
  print 'PROCCESSING: ['
  orgs.each do |i|
    # construct data into each object via unique identifier
    org_url = "https://activities.osu.edu/involvement/student_organizations/find_a_student_org?i=#{i['id']}"

    agent = Mechanize.new
    page = agent.get org_url

    # get values from form via XPath
    name = page.search('//div/h4')
    table = page.search('//form/div/table/tr')
    # store into name object
    i['Name'] = name.text
    count = 0
    while count < table.length
      combo = table[count].text.split(':')
      if combo[0].include? 'Campus'
        i['Campus'] = combo[1].strip
        # puts i.campus
      elsif combo[0].include? 'Status'
        i['Status'] = combo[1].strip
      elsif combo[0].include? 'Purpose Statement'
        i['Purpose Statement'] = combo[1].strip
      elsif combo[0].include? 'Primary Leader'
        i['Primary Leader'] = combo[1].strip
      elsif combo[0].include? 'Secondary Leader'
        i['Secondary Leader'] = combo[1].strip
      elsif combo[0].include? 'Treasurer Leader'
        i['Treasurer Leader'] = combo[1].strip
      elsif combo[0].include? 'Advisor'
        i['Advisor'] = combo[1].strip
      elsif combo[0].include? 'Organization Email'
        i['Organization Email'] = combo[1].strip
      elsif combo[0].include? 'Website'
        # Since we split by :, links often have : so we repatch it here
        link_count = 2
        link = combo[1].strip
        while link_count < combo.length
          link += ':' + combo[link_count].strip
          link_count += 1
        end
        i['Website'] = link
      # puts i.website
      elsif combo[0].include? 'Facebook Group Page'
        # Since we split by :, links often have : so we repatch it here
        link_count = 2
        link = combo[1].strip
        while link_count < combo.length
          link += ':' + combo[link_count].strip
          link_count += 1
        end
        i['Facebook Group Page'] = link
      # puts i.facebook 
      elsif (combo[0].include? 'Primary Type') || (combo[0].include? 'Secondary Types')
        combo[1].insert(combo[1].index(/[a-z]{1}[A-Z]{1}/) + 1, '*') while combo[1].match?(/[a-z]{1}[A-Z]{1}/)
        combo[1].split('*').each do |type|
          (i['Types'].push type.strip).uniq!
        end
      elsif combo[0].include? 'Primary Make Up'
        i['Primary Make Up'] = combo[1].strip
      elsif combo[0].include? 'Constitution'
        i['Constitution'] = combo[1].strip
      elsif combo[0].include? 'Meeting Time and Place'
        i['Meeting Time and Place'] = combo[1].strip
      elsif combo[0].include? 'Office Location'
        i['Office Location'] = combo[1].strip
      elsif combo[0].include? 'Membership Type'
        i['Membership Type'] = combo[1].strip
      elsif combo[0].include? 'Membership Contact'
        i['Membership Contact'] = combo[1].strip
      elsif combo[0].include? 'Time of Year for New Membership'
        i['Time of Year for New Membership'] = combo[1].strip
      elsif combo[0].include? 'How does a Prospective Member Apply'
        i['How does a Prospective Member Apply'] = combo[1].strip
      elsif combo[0].include? 'Charge Dues'
        i['Charge Dues'] = combo[1].strip
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
    page = agent.get "https://activities.osu.edu/involvement/student_organizations/find_a_student_org?i=#{org['id']}"

    # get values from form via XPath
    name = page.search('//div/h4')
    table = page.search('//form/div/table/tr')

    # store into name object
    org['Name'] = name.text.strip
    (0...table.length).each do |i|
      combo = table[i].text.split ':'
      if (combo[0].include? 'Primary Type') || (combo[0].include? 'Secondary Types')
        combo[1].insert(combo[1].index(/[a-z]{1}[A-Z]{1}/) + 1, '*') while combo[1].match?(/[a-z]{1}[A-Z]{1}/)
        combo[1].split('*').each do |type|
          (org['Types'].push type.strip).uniq!
        end
      else
        org[combo[0].strip] = attr_parse combo, attr
      end
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
  if attr_line[0] == 'Facebook Group Page' || attr_line[0] == 'Website'
    link = attr_line[1...attr_line.length]
    return link.reduce { |whole, seg| whole.strip + ':' + seg.strip }
  end

  attr_line[1].strip if attr.include? attr_line[0].strip
end