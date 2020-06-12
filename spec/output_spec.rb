# frozen_string_literal: true

# File created on 06/20/2020 by Kevin Dong

require './org.rb'
load './output.rb'

describe '.output_handler' do
  context 'when testing output handler' do
    it 'should clean exit if orgs is empty' do
      orgs = []
      output_handler orgs
    end
    it 'should clean exit if orgs is empty' do
      orgs = []
      output_console orgs
    end
    it 'should clean exit if orgs is empty' do
      orgs = []
      output_file orgs
    end
    it 'should print 1' do
      org = Org.new('test')
      org.url = 'www.gov.edu'
      org.pic_url = 'www.gov.pic'
      org.campus = 'behind you'
      orgs = [org]
      output_console orgs
    end
    it 'should print 2' do
      orgs = [Org.new('test1'), Org.new('test2')]
      output_console orgs
    end
    it 'should write 1' do
      org = Org.new('test')
      org.url = 'www.gov.edu'
      org.pic_url = 'www.gov.pic'
      org.campus = 'behind you'
      orgs = [org]
      output_file orgs
    end
    it 'should write 2' do
      orgs = [Org.new('test1'), Org.new('test2')]
      output_console orgs
    end
  end
end