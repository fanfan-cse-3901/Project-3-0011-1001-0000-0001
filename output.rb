# frozen_string_literal: true

# File created on 06/10/2020 by Kevin Dong
=begin
Handles various output methods.
=end

require './org.rb'

# Created on 06/10/2020 by Kevin Dong
# Public: Choose between different outputs given pruned orgs list
#
# orgs - array of org objects
# 
# Returns nothing.
def output_handler orgs
  if orgs.empty?
    puts 'Nothing to output'
    return
  end

  puts "[1] Console\n[2] File"
  loop do
    print 'Selection: '
    sel = gets.to_i
    next unless sel >= 1 && sel <= 2

    output_console orgs if sel == 1
    output_file orgs if sel == 2
    break
  end
end

# Created on 06/10/2020 by Kevin Dong
# Internal: Outputs Org object info to console
#
# orgs - Array of Org Objects
#
# Returns nothing.
def output_console orgs
  orgs.each { |org| puts org }
end

# Created on 06/11/2020 by Kevin Dong
# Internal: Outputs Org Object info to file
#
# orgs - Array of Org Objects
#
# Returns nothing.
def output_file orgs
  file = File.open './testing/Organizations.txt', 'w' do |line|
    orgs.each do |org|
      line.write org.to_s
    end
  end
  puts 'File created at /testing/Organizations.txt'
end
