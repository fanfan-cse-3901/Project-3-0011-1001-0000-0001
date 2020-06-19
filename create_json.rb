# frozen_string_literal: true

# File created 06/17/2020 by Troy Stein: creates a json file from a file name and a list of org objects
# Edited 06/18/2020 by Troy Stein and Yifan Yao: modified to account for the way orgs is set up
# Public: stores organizations into a .json file
#
# orgs : array of hashes (each hash represents info about the organization)
#
# file : name of .json file for json
#
# Returns nothing
def output_json orgs, file
  filled = File.open file, 'w' do |line|
    line.puts "{ \n"
    orgs.each do |org|
      line.puts "\t\"#{org['Name']}\" : { \n"
      org.each do |key, val|
        if key == 'Types'
          line.puts "\t\t\"#{'Primary Type'}\" : \"#{org[key][0]}\",\n"
          line.puts "\t\t\"#{'Secondary Types'}\" : \"#{org[key][1..org[key].length]}\",\n"
        elsif key == 'Charge Dues'
          line.puts "\t\t\"#{key}\" : \"#{val}\"\n"
        else
          line.puts "\t\t\"#{key}\" : \"#{val}\",\n"
        end
      end
      line.puts "\t}" if org == orgs[orgs.length - 1]
      line.puts "\t}," if org != orgs[orgs.length - 1]
      line.puts "\n"
    end
    line.puts '}'
  end
end