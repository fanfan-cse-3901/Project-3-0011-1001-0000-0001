# frozen_string_literal: true

# File created on 06/10/2020 by Kevin Dong
=begin
Handles various output methods.
=end
require 'rubygems'
require './lib/volunteer.rb'
require './lib/output_json.rb'

# Created on 06/10/2020 by Kevin Dong
# Edited on 06/15/2020 by Amanda Cheng: Introduced extra functionality to html file and introduced 2 new parameters
# Public: Choose between different outputs given pruned orgs list
#
# orgs - array of org objects
# attr - Array of String Attributes that User Selected
# rec - Array of Recommended Orgs Arrays (Name for element 0, url for element 1)
# 
# Returns nothing.
def output_handler orgs, attr, rec
  return puts 'Nothing to output' if orgs.empty?

  puts "[1] Console\n[2] File\n[3] HTML\n[4] JSON"
  loop do
    print 'Selection: '
    sel = gets
    next unless /[1-4]/.match sel

    output_console orgs, rec if sel.to_i == 1
    if sel.to_i > 1
      print 'Output File Path (include correct extensions & . in front): '
      path = gets.chomp
      output_file orgs, rec, path if sel.to_i == 2
      output_html orgs, attr, rec, path if sel.to_i == 3
      output_json orgs, rec, path if sel.to_i == 4
    end
    break
  end
end

# Created on 06/10/2020 by Kevin Dong
# Edited on 06/15/2020 by Amanda Cheng: Updated output to deal with hash
# Internal: Outputs Org object info to console
#
# orgs - Array of Org Objects
#
# Returns nothing.
def output_console orgs, rec
  orgs.each do |org|
    org.each do |key, value|
      puts "#{key}: #{value}"
    end
    puts
  end
  print_volunteer_events
  unless rec.empty?
    puts 'Recommended for You'
    rec.each do |rec|
    puts "#{rec[0]}: #{rec[1]}"
    end
  end
end

# Created on 06/11/2020 by Kevin Dong
# Edited on 06/15/2020 by Amanda Cheng: Updated output to deal with hash
# Internal: Outputs Org Object info to file
#
# orgs - Array of Org Objects
# path - filename
#
# Returns nothing.
def output_file orgs, rec, path
  file = File.open path, 'w' do |line|
    orgs.each do |org|
      org.each do |key, value|
        line.puts "#{key}: #{value}"
      end
      line.puts
    end
  end
  unless rec.empty?
    line.puts 'Recommended for You'
    rec.each do |rec|
      puts "#{rec[0]}: #{rec[1]}"
    end
  end
  puts "File created at #{path}"
end

# Created on 06/15/2020 by Amanda Cheng
# Internal: Outputs Org Object info to html file
#
# orgs - Array of Org Hashes
# attr - Array of String Attributes that User Selected
# rec - Array of Recommended Orgs Arrays (Name for element 0, url for element 1)
# path - filename
#
# Returns nothing.
def output_html orgs, attr, rec, path
  file = File.open path, 'w' do |line|
    line.puts '<!DOCTYPE html>'
    line.puts '<html lang="en-US">'
    line.puts '<head>'
    # line.puts '<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />'
    line.puts '<title>Your OSU Organizations</title>'
    line.puts '</head>'
    line.puts '<body>'
    line.puts '<h1>List of Organizations</h1>'
    line.puts '<p> Here are the OSU Organizations you selected.'
    line.print ' Recommended orgs at the bottom.' unless rec.empty?
    line.print ' </p>'
    orgs.each do |org|
      # Output the name first.
      line.puts "<h3><a href=\"https://activities.osu.edu/involvement/student_organizations/find_a_student_org?i=#{org['id']}\">#{org['Name']} </a></h3>"
      line.puts '<ul>'
      # Go through each attribute array and only print out necessary attributes
      attr.each do |attr|
        # 'Types'
        if attr == 'Primary Type'
          line.puts "<li>#{attr}: #{org['Types'][0]}</li>"
        elsif attr == 'Secondary Types'
          line.puts "<li>#{attr}: #{org['Types'][1...org['Types'].length]}</li>"
        else
          line.puts "<li>#{attr}: #{org[attr]}</li>"
        end
      end
      line.puts '</ul>'
    end
    line.puts '<br />'
    unless rec.empty?
      line.puts '<h2>Recommended for You</h2>'
      # Output an unordered list of recommended organizations and their urls
      line.puts '<ul>'
      rec.each do |rec|
        line.puts "<li>#{rec[0]}: #{rec[1]}</li>"
        # line.puts "<p>#{rec[1]}</p>"
      end
      line.puts '</ul>'
    end
    line.puts '</body>'
    line.puts '</html>'
  end
  puts "File created at #{path}"
end
