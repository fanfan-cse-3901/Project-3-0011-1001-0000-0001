# frozen_string_literal: true

# File created on 06/10/2020 by Kevin Dong
=begin
Handles various output methods.
=end

require './org.rb'
require 'rubygems'

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
  if orgs.empty?
    puts 'Nothing to output'
    return
  end

  puts "[1] Console\n[2] File\n[3] HTML"
  loop do
    print 'Selection: '
    sel = gets.to_i
    next unless sel >= 1 && sel <= 2

    output_console orgs if sel == 1
    if sel > 1
      print 'Output File Path (include correct extensions): '
      path = gets.chomp
      output_file orgs, path if sel == 2
      output_html orgs, attr, rec, path if sel == 3
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
def output_console orgs
  orgs.each do |org|
    org.each do |key, value|
      puts "#{key}: #{value}"
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
def output_file orgs, path
  file = File.open path, 'w' do |line|
    orgs.each do |org|
      org.each do |key, value|
        line.puts "#{key}: #{value}"
      end
      line.puts
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
    line.puts '<html lang="en">'
    line.puts '<head>'
    # line.puts '<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />'
    line.puts '<title>Your OSU Organizations</title>'
    line.puts '</head>'
    line.puts '<body>'
    line.puts '<h1>List of Organizations</h1>'
    line.puts '<p> Here are the OSU Organizations you selected. Your Recommended Orgs are at the bottom. </p>'
    orgs.each do |org|
      # Output the name first.
      line.puts "<h3> #{org['name']} </h3>"
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
    line.puts '<h2>Recommended for You</h2>'
    # Output an unordered list of recommended organizations and their urls
    line.puts '<ul>'
    rec.each do |rec|
      line.puts "<li>#{rec[0]}: #{rec[1]}</li>"
      # line.puts "<p>#{rec[1]}</p>"
    end
    line.puts '</ul>'
    line.puts '</body>'
    line.puts '</html>'
  end
  puts "File created at #{path}"
end

# file = File.open './testing/Organizations.html', 'w' do |line|
#   # line.puts '<?xml version="1.0" encoding="ISO-8859-1" ?>'
#   # line.puts '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">'
#   line.puts '<html lang = "en">'
#   line.puts '<head>'
#   # line.puts '<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />'
#   line.puts '<title>OSU Organizations</title>'
#   line.puts '</head>'
#   line.puts '<body>'
#   line.puts '<h1>List of Organization</h1>'
#   line.puts '<p> Here are your Organizations. Your Recommended Orgs are at the bottom </p>'
#   #orgs.each do |org|
#     # Output the name first.
#   #line.puts "<h3> Waterski </h3>"
#   #   line.puts '<ul>'
#   #   # Go through each attribute array and only print out necessary attributes
#   #   # attr.each do |attr|
#   #     line.puts "<li>Campus:</li>"
#   #     line.puts "<p>Columbus</p>"
#   # line.puts "<li>Constitution:</li>"
#   # line.puts "<p>google.com</p>"
#   #   # end
#   #   line.puts '</ul>'
#   # #end
#   # line.puts "<h3> Waffle House Club </h3>"
#   # line.puts '<ul>'
#   # Go through each attribute array and only print out necessary attributes
#   # attr.each do |attr|
#   # line.puts "<li>Campus:</li>"
#   # line.puts "<p>Newark</p>"
#   # line.puts "<li>Constitution:</li>"
#   # line.puts "<p>google.com</p>"
#   # end
#   # line.puts '</ul>'
#   line.puts '<br />'
#   line.puts '<h2>Recommended for You</h2>'
#   # Output an unordered list of recommended organizations
#   line.puts '<ul>'
#   #rec.each do |rec|
#   #   line.puts "<li>Snowboarding Club </li>"
#   #end
#   line.puts '</ul>'
#   line.puts '</body>'
#   line.puts '</html>'
# end
# puts 'File created at /testing/Organizations.txt'
# # Launchy::Browser.run('./testing/Organizations.html')