# frozen_string_literal: true

# File created on 06/10/2020 by Kevin Dong

require './get_org_list.rb'
require './output.rb'

# Edited on 06/15/2020 by Kevin Dong: Fixed for hash
describe '.output_handler independent methods' do
  context 'when testing output handler' do
    it 'should clean exit if orgs is empty' do
      url = 'https://activities.osu.edu/involvement/student_organizations/find_a_student_org?v=list&l=W&c=Columbus'
      orgs = []
      output_handler orgs, [], url
    end
  end
  context 'when testing output_console' do
    it 'should print attr id followed by types on each line seperated by newline' do
      url = 'https://activities.osu.edu/involvement/student_organizations/find_a_student_org?v=list&l=W&c=Columbus'
      orgs = []
      get_org_list url, orgs
      output_console orgs
    end
  end
  context 'when testing output_file' do
    it 'should print attr id followed by types on each line seperated by newline' do
      url = 'https://activities.osu.edu/involvement/student_organizations/find_a_student_org?v=list&l=W&c=Columbus'
      orgs = []
      get_org_list url, orgs
      output_file orgs, './testing/Organizations.txt'
    end
  end
  context 'when testing output_html' do
    it 'should print according to format with N/A for all 25' do
      url = 'https://activities.osu.edu/involvement/student_organizations/find_a_student_org?v=list&l=W&c=Columbus'
      orgs = []
      get_org_list url, orgs
      output_html orgs, [], [], './testing/Organizations.html'
    end
  end
end
