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
    File.write file, "{ \n"
    orgs.each do |n|
        puts "#{n}"
        File.write file, "\t\"#{n['Name']}\" : { \n", mode: 'a'
        File.write file, "\t\t\"id\" : \"#{n['id']}\",\n", mode: 'a'
        File.write file, "\t\t\"campus\" : \"#{n['Campus']}\",\n", mode: 'a'
        File.write file, "\t\t\"status\" : \"#{n['Status']}\",\n", mode: 'a'
        File.write file, "\t\t\"purpose statement\" : \"#{n['Purpose Statement']}\",\n", mode: 'a'
        File.write file, "\t\t\"primary leader\" : \"#{n['Primary Leader']}\",\n", mode: 'a'
        File.write file, "\t\t\"secondary leader\" : \"#{n['Secondary Leader']}\",\n", mode: 'a'
        File.write file, "\t\t\"treasurer leader\" : \"#{n['Treasurer Leader']}\",\n", mode: 'a'
        File.write file, "\t\t\"advisor\" : \"#{n['Advisor']}\",\n", mode: 'a'
        File.write file, "\t\t\"organization email\" : \"#{n['Organization Email']}\",\n", mode: 'a'
        File.write file, "\t\t\"website\" : \"#{n['Website']}\",\n", mode: 'a'
        File.write file, "\t\t\"facebook group page\" : \"#{n['Facebook Group Page']}\",\n", mode: 'a'
        File.write file, "\t\t\"primary type\" : \"#{n['Primary Type']}\",\n", mode: 'a'
        File.write file, "\t\t\"secondary types\" : \"#{n['Types']}\",\n", mode: 'a'
        File.write file, "\t\t\"primary make up\" : \"#{n['Primary Make Up']}\",\n", mode: 'a'
        File.write file, "\t\t\"constitution\" : \"#{n['Constitution']}\",\n", mode: 'a'
        File.write file, "\t\t\"meeting time and place\" : \"#{n['Meeting Time and Place']}\",\n", mode: 'a'
        File.write file, "\t\t\"office location\" : \"#{n['Office Location']}\",\n", mode: 'a'
        File.write file, "\t\t\"membership type\" : \"#{n['Membership Type']}\",\n", mode: 'a'
        File.write file, "\t\t\"membership contact\" : \"#{n['Membership Contact']}\",\n", mode: 'a'
        File.write file, "\t\t\"time of year new membership\" : \"#{n['Time of Year for New Membership']}\",\n", mode: 'a'
        File.write file, "\t\t\"how does a prospective member apply\" : \"#{n['How does a Prospective Member Apply']}\",\n", mode: 'a'
        File.write file, "\t\t\"charge dues\" : \"#{n['Charge Dues']}\"\n", mode: 'a'
        File.write file, "\t}", mode: 'a'
        File.write file, ',', mode: 'a' if n != orgs [orgs.length - 1]
        File.write file, "\n", mode: 'a'
    end
    File.write file, '}', mode: 'a'
end

