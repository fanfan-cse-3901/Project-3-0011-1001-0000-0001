# frozen_string_literal: true

# File created 06/16/2020 by Troy Stein: displays all volunteer events, Ordered by related attributes
require 'mechanize'

# Public: displays all volunteer events
#
#
# Returns nothing.
def print_volunteer_events
  agent = Mechanize.new
  page = agent.get 'https://activities.osu.edu/involvement/service_outreach/'
  temp = page.at('//*[@id="ctl00_ContentBody_pageFormControl_OppOrgSearch"]/h4').text.split.join(' ')
  entries = temp.match(/\d+/)[0].to_i # extracts index
  m = 0
  puts 'Optional Volunteer Events: More details on https://activities.osu.edu/involvement/service_outreach/'
  puts
  begin
    page = agent.get "https://activities.osu.edu/involvement/service_outreach/?page=#{m / 5}&d=u"
    puts page.at("//ul/li[#{ (m % 5) + 1 }]/div[1]/div[1]/a/text()").text.strip
    m += 1
  end until entries == m
end
