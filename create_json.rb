# frozen_string_literal: true

require './org.rb'
# File created 06/17/2020 by Troy Stein: creates a csv file from a file name and a list of org objects
# Public: stores organizations into a .json file
#
# orgs : hash of org objects
#
# file : name of .json file for json
#
#Returns nothing
def create_json orgs, file
orgs = [Org.new(0), Org.new(1),Org.new(2), Org.new(3), Org.new('kevin'), Org.new('Prachiti'), Org.new("T-roy9"), Org.new("yifan"),Org.new('AmAndA')]
File.write file,"{ \n"
orgs.each do |n|
  puts 'iter'
  File.write file,"\t\"#{orgs[n].name}\" : { \n", mode:'a'
  File.write file, "\t\t\"id\" : \"#{orgs[n].id}\",\n", mode:'a'
  File.write file, "\t\t\"campus\" : \"#{orgs[n].campus}\",\n", mode:'a'
  File.write file, "\t\t\"status\" : \"#{orgs[n].status}\",\n", mode:'a'
  File.write file, "\t\t\"purpose\" : \"#{orgs[n].purpose}\",\n", mode:'a'
  File.write file, "\t\t\"p_leader\" : \"#{orgs[n].p_leader}\",\n", mode:'a'
  File.write file, "\t\t\"s_leader\" : \"#{orgs[n].s_leader}\",\n", mode:'a'
  File.write file, "\t\t\"t_leader\" : \"#{orgs[n].t_leader}\",\n", mode:'a'
  File.write file, "\t\t\"advisor\" : \"#{orgs[n].advisor}\",\n", mode:'a'
  File.write file, "\t\t\"email\" : \"#{orgs[n].email}\",\n", mode:'a'
  File.write file, "\t\t\"website\" : \"#{orgs[n].website}\",\n", mode:'a'
  File.write file, "\t\t\"facebook\" : \"#{orgs[n].facebook}\",\n", mode:'a'
  File.write file, "\t\t\"p_type\" : \"#{orgs[n].p_type}\",\n", mode:'a'
  File.write file, "\t\t\"s_type\" : \"#{orgs[n].s_type}\",\n", mode:'a'
  File.write file, "\t\t\"make_up\" : \"#{orgs[n].make_up}\",\n", mode:'a'
  File.write file, "\t\t\"constitution\" : \"#{orgs[n].constitution}\",\n", mode:'a'
  File.write file, "\t\t\"time_place\" : \"#{orgs[n].time_place}\",\n", mode:'a'
  File.write file, "\t\t\"office_location\" : \"#{orgs[n].office_location}\",\n", mode:'a'
  File.write file, "\t\t\"membership_type\" : \"#{orgs[n].membership_type}\",\n", mode:'a'
  File.write file, "\t\t\"membership_contact\" : \"#{orgs[n].membership_contact}\",\n", mode:'a'
  File.write file, "\t\t\"new_membership_time\" : \"#{orgs[n].new_membership_time}\",\n", mode:'a'
  File.write file, "\t\t\"how_to_apply\" : \"#{orgs[n].how_to_apply}\",\n", mode:'a'
  File.write file, "\t\t\"charge_dues\" : \"#{orgs[n].charge_dues}\"\n", mode:'a'
  File.write file, "\t}", mode:'a'
  File.write file, ',', mode:'a' if n+1 != orgs.length
  File.write file, "\n", mode:'a'
end
File.write file, '}', mode:'a'
end