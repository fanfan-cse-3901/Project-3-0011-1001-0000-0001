# frozen_string_literal: true

# File created 06/17/2020 by Troy Stein: creates a csv file from a file name and a list of org objects
# Public: stores organizations into a .json file
#
# orgs : hash of org objects
#
# file : name of .json file for json
#
# Returns nothing
def create_json orgs, file
  File.write file, "{ \n"
  keys = orgs.keys
  orgs.each do |n|
    File.write file, "\t\"#{n[0]}\" : { \n", mode: 'a'
    File.write file, "\t\t\"id\" : \"#{n[1].id}\",\n", mode: 'a'
    File.write file, "\t\t\"campus\" : \"#{n[1].campus}\",\n", mode: 'a'
    File.write file, "\t\t\"status\" : \"#{n[1].status}\",\n", mode: 'a'
    File.write file, "\t\t\"purpose\" : \"#{n[1].purpose}\",\n", mode: 'a'
    File.write file, "\t\t\"p_leader\" : \"#{n[1].p_leader}\",\n", mode: 'a'
    File.write file, "\t\t\"s_leader\" : \"#{n[1].s_leader}\",\n", mode: 'a'
    File.write file, "\t\t\"t_leader\" : \"#{n[1].t_leader}\",\n", mode: 'a'
    File.write file, "\t\t\"advisor\" : \"#{n[1].advisor}\",\n", mode: 'a'
    File.write file, "\t\t\"email\" : \"#{n[1].email}\",\n", mode: 'a'
    File.write file, "\t\t\"website\" : \"#{n[1].website}\",\n", mode: 'a'
    File.write file, "\t\t\"facebook\" : \"#{n[1].facebook}\",\n", mode: 'a'
    File.write file, "\t\t\"p_type\" : \"#{n[1].p_type}\",\n", mode: 'a'
    File.write file, "\t\t\"s_type\" : \"#{n[1].s_type}\",\n", mode: 'a'
    File.write file, "\t\t\"make_up\" : \"#{n[1].make_up}\",\n", mode: 'a'
    File.write file, "\t\t\"constitution\" : \"#{n[1].constitution}\",\n", mode: 'a'
    File.write file, "\t\t\"time_place\" : \"#{n[1].time_place}\",\n", mode: 'a'
    File.write file, "\t\t\"office_location\" : \"#{n[1].office_location}\",\n", mode: 'a'
    File.write file, "\t\t\"membership_type\" : \"#{n[1].membership_type}\",\n", mode: 'a'
    File.write file, "\t\t\"membership_contact\" : \"#{n[1].membership_contact}\",\n", mode: 'a'
    File.write file, "\t\t\"new_membership_time\" : \"#{n[1].new_membership_time}\",\n", mode: 'a'
    File.write file, "\t\t\"how_to_apply\" : \"#{n[1].how_to_apply}\",\n", mode: 'a'
    File.write file, "\t\t\"charge_dues\" : \"#{n[1].charge_dues}\"\n", mode: 'a'
    File.write file, "\t}", mode: 'a'
    File.write file, ',', mode: 'a' if n[0] != keys[orgs.length() - 1]
    File.write file, "\n", mode: 'a'
  end
  File.write file, '}', mode: 'a'
end
