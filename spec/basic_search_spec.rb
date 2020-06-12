# frozen_string_literal: true

# Created on 06/10/2020 by Prachiti Garge

# Edited on 06/12/2020 by Prachiti Garge: Added test cases

require './basic_search'
require 'spec_helper'
require 'rspec'
require 'stringio'
require 'mechanize'

RSpec.describe Searching do
  page = Mechanize.new.get 'https://activities.osu.edu/involvement/student_organizations/find_a_student_org/?v=list'
  describe 'get_campus' do
    it 'gives right extension for all campuses' do
      in1 = StringIO.new('1\n')
      $stdin = in1
      expect(Searching.get_campus(page)).to(eq('&c=All'))
      $stdin = STDIN
    end

    it 'gives right extension for Lima' do
      in2 = StringIO.new('3\n')
      $stdin = in2
      expect(Searching.get_campus (page)).to(eq('&c=Lima'))
      $stdin = STDIN
    end

    it 'gives right extension for Wooster' do
      in3 = StringIO.new('7')
      $stdin = in3
      expect(Searching.get_campus (page)).to(eq('&c=Wooster'))
      $stdin = STDIN
    end

    it 'gives right extension for Mansfield' do
      in4 = StringIO.open('8')
      in4.puts '4'
      $stdin = in4
      expect(Searching.get_campus (page)).to(eq('&c=Mansfield'))
      $stdin = STDIN
    end
  end

  describe 'get_directory' do
    it 'gives right extension for numbers directory' do
      in5 = StringIO.new('1')
      $stdin = in5
      expect(Searching.get_directory).to(eq('&l=1'))
      $stdin = STDIN
    end

    it 'gives right extension for S directory' do
      in6 = StringIO.new('S')
      $stdin = in6
      expect(Searching.get_directory).to(eq('&l=S'))
      $stdin = STDIN
    end

    it 'gives right extension for all directory' do
      in7 = StringIO.new('0')
      $stdin = in7
      expect(Searching.get_directory).to(eq('&l=ALL'))
      $stdin = STDIN
    end

    it 'gives right extension for F directory' do
      in8 = StringIO.open('abc')
      in8.puts 'f'
      $stdin = in8
      expect(Searching.get_directory).to(eq('&l=F'))
      $stdin = STDIN
    end
  end

  describe 'get_search' do
    it 'gives right extension for search of ab74' do
      in9 = StringIO.new('ab74')
      $stdin = in9
      expect(Searching.get_search).to(eq('&s=ab74'))
      $stdin = STDIN
    end

    it 'gives right extension for search of Bull\'s eye' do
      in10 = StringIO.new('Bull\'s eye')
      $stdin = in10
      expect(Searching.get_search).to(eq('&s=Bull%27s+eye'))
      $stdin = STDIN
    end

    it 'gives right extension for search of .\';l\'.;\'4r\\' do
      in11 = StringIO.new('.\';l\'.;\'4r\\')
      $stdin = in11
      expect(Searching.get_search).to(eq('&s=.%27%3Bl%27.%3B%274r%5C'))
      $stdin = STDIN
    end

    it 'gives right extension for search of \n' do
      in12 = StringIO.new('\n')
      $stdin = in12
      expect(Searching.get_search).to(eq(''))
      $stdin = STDIN
    end
  end

  describe 'get_category' do
    it 'gives right extension for all categories' do
      in13 = StringIO.new('0')
      $stdin = in13
      expect(Searching.get_category (page)).to(eq(''))
      $stdin = STDIN
    end

    it 'gives right extension for Community Service/Service Learning category' do
      in14 = StringIO.open('3')
      in14.puts '\n'
      $stdin = in14
      expect(Searching.get_category (page)).to(eq('&m=Community+Service%2fService+Learning'))
      $stdin = STDIN
    end

    it 'gives right extension for Ethnic/Cultural,Governance Organizations, Special Interest categories' do
      in15 = StringIO.open('6')
      in15.puts '11'
      in15.puts 'abe0'
      in15.puts '5'
      in15.puts '\n'
      $stdin = in15
      expect(Searching.get_category (page)).to(eq('&m=Ethnic%2fCultural%3bGovernance+Organizations%3bSpecial+Interest'))
      $stdin = STDIN
    end
  end

  describe 'get_text_type' do
    it 'gives right extension for search type all' do
      in16 = StringIO.new('1')
      $stdin = in16
      expect(Searching.get_text_type (page)).to(eq('&t=all'))
      $stdin = STDIN
    end

    it 'gives right extension for search type purpose' do
      in17 = StringIO.new('3')
      $stdin = in17
      expect(Searching.get_text_type (page)).to(eq('&t=purpose'))
      $stdin = STDIN
    end

    it 'gives right extension for search type name' do
      in18 = StringIO.new('How are you?')
      in18.puts '2'
      $stdin = in18
      expect(Searching.get_text_type (page)).to(eq('&t=name'))
      $stdin = STDIN
    end
  end

  describe 'get_reg_win' do
    it 'gives right extension for all reg windows' do
      in19 = StringIO.new('1')
      $stdin = in19
      expect(Searching.get_reg_win (page)).to(eq('&ot=0'))
      $stdin = STDIN
    end

    it 'gives right extension for reg window in Spring' do
      in20 = StringIO.new('2')
      $stdin = in20
      expect(Searching.get_reg_win (page)).to(eq('&ot=1'))
      $stdin = STDIN
    end

    it 'gives right extension for reg window in Autumn' do
      in21 = StringIO.new('3')
      $stdin = in21
      expect(Searching.get_reg_win (page)).to(eq('&ot=2'))
      $stdin = STDIN
    end

    it 'gives right extension for reg window in Autumn' do
      in22 = StringIO.open('Bamboozled')
      in22.puts '3'
      $stdin = in22
      expect(Searching.get_reg_win (page)).to(eq('&ot=2'))
      $stdin = STDIN
    end
  end

  describe 'show_inactive_org' do
    it 'gives right extension for showing inactive organizations' do
      in23 = StringIO.new('y')
      $stdin = in23
      expect(Searching.show_inactive_org).to(eq('&a=0'))
      $stdin = STDIN
    end

    it 'gives right extension for showing only active organizations' do
      in24 = StringIO.new('N')
      $stdin = in24
      expect(Searching.show_inactive_org).to(eq('&a=1'))
      $stdin = STDIN
    end

    it 'gives right extension for showing only active organizations' do
      in25 = StringIO.open('Kaboom98')
      in25.puts 'n'
      $stdin = in25
      expect(Searching.show_inactive_org).to(eq('&a=1'))
      $stdin = STDIN
    end
  end
end
