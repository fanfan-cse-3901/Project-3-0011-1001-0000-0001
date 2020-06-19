# frozen_string_literal: true

# File created on 06/14/2020 by Kevin Dong

require './lib/get_org_list.rb'
require './lib/get_org_data.rb'

describe '.get_org_data' do
  context 'when given regular page' do
    it 'should populate array of hashes' do
      url = 'https://activities.osu.edu/involvement/student_organizations/find_a_student_org?v=list&l=W&c=Columbus'
      orgs = []
      get_org_list url, orgs
      get_org_data orgs
      orgs.each do |i|
        # puts i.to_s
      end
    end
  end
end

describe '.get_org_attr' do
  context 'when given regular page' do
    it 'should populate array of hashes' do
      url = 'https://activities.osu.edu/involvement/student_organizations/find_a_student_org?v=list&l=W&c=Columbus'
      orgs = []
      get_org_list url, orgs
      get_org_attr orgs, ['Primary Type', 'Secondary Types']
      orgs.each do |i|
        puts i.to_s
      end
    end
  end
end

describe '.get_org_attr' do
  context 'when given regular page' do
    it 'should populate array of hashes' do
      url = 'https://activities.osu.edu/involvement/student_organizations/find_a_student_org?v=list&l=W&c=Columbus'
      orgs = []
      get_org_list url, orgs
      get_org_attr orgs, ['Campus', 'Status', 'Purpose Statement', 'Primary Leader', 'Secondary Leader', 'Treasurer Leader',
                          'Advisor', 'Organization Email', 'Facebook Group Page', 'Website', 'Primary Type', 'Secondary Types',
                          'Primary Make Up', 'Constitution', 'Meeting Time and Place', 'Office Location', 'Membership Type',
                          'Membership Contact', 'Time of Year for New Membership', 'How does a Prospective Member Apply',
                          'Charge Dues']
      orgs.each do |i|
        puts i.to_s
      end
    end
  end
end