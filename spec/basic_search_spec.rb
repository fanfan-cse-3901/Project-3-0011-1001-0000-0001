# frozen_string_literal: true

# Created on 06/10/2020 by Prachiti Garge

# Edited on 06/12/2020 by Prachiti Garge: Added test cases
# Edited on 06/14/2020 by Prachiti Garge: Debugged StringIO for multiple inputs
# DO NOT RUN. WILL GIVE ERRORS. INSTEAD, REFERENCE basic_search_test_plan.txt
require './basic_search'
require 'spec_helper'
require 'rspec'
require 'stringio'
require 'mechanize'

RSpec.describe Searching do
  page = Mechanize.new.get 'https://activities.osu.edu/involvement/student_organizations/find_a_student_org/?v=list'
  describe 'get_campus' do
    it 'gives right extension for all campuses' do
      in1 = StringIO.new('1')
      $stdin = in1
      expect(Searching.get_campus page).to(eq('&c=All'))
      $stdin = STDIN
      in1.close
    end

    it 'gives right extension for Lima' do
      in2 = StringIO.new('3')
      $stdin = in2
      expect(Searching.get_campus page).to(eq('&c=Lima'))
      $stdin = STDIN
      in2.close
    end

    it 'gives right extension for Wooster' do
      in3 = StringIO.new('7')
      $stdin = in3
      expect(Searching.get_campus page).to(eq('&c=Wooster'))
      $stdin = STDIN
      in3.close
    end

    it 'gives right extension for Mansfield' do
      in4 = StringIO.open do |a|
        a.puts '8'
        a.puts '4'
        a.string
      end
      $stdin = in4
      expect(Searching.get_campus page).to(eq('&c=Mansfield'))
      $stdin = STDIN
        in4.close
    end
  end

  describe 'get_directory' do
    it 'gives right extension for numbers directory' do
      in5 = StringIO.new('1')
      $stdin = in5
      expect(Searching.get_directory).to(eq('&l=1'))
      $stdin = STDIN
      in5.close
    end

    it 'gives right extension for S directory' do
      in6 = StringIO.new('S')
      $stdin = in6
      expect(Searching.get_directory).to(eq('&l=S'))
      $stdin = STDIN
      in6.close
    end

    it 'gives right extension for all directory' do
      in7 = StringIO.new('0')
      $stdin = in7
      expect(Searching.get_directory).to(eq('&l=ALL'))
      $stdin = STDIN
      in7.close
    end

    it 'gives right extension for F directory' do
      in8 = StringIO.open do |a|
        a.puts 'abc'
        a.puts 'f'
        a.string
      end
      $stdin = in8
      expect(Searching.get_directory).to(eq('&l=F'))
      $stdin = STDIN
      in8.close
    end
  end

  describe 'get_search' do
    it 'gives right extension for search of ab74' do
      in9 = StringIO.new('ab74')
      $stdin = in9
      expect(Searching.get_search).to(eq('&s=ab74'))
      $stdin = STDIN
      in9.close
    end

    it 'gives right extension for search of Bull\'s eye' do
      in10 = StringIO.new('Bull\'s eye')
      $stdin = in10
      expect(Searching.get_search).to(eq('&s=Bull%27s+eye'))
      $stdin = STDIN
      in10.close
    end

    it 'gives right extension for search of .\';l\'.;\'4r\\' do
      in11 = StringIO.new('.\';l\'.;\'4r\\')
      $stdin = in11
      expect(Searching.get_search).to(eq('&s=.%27%3Bl%27.%3B%274r%5C'))
      $stdin = STDIN
      in11.close
    end

    it 'gives right extension for search of \n' do
      in12 = StringIO.new('\n')
      $stdin = in12
      expect(Searching.get_search).to(eq(''))
      $stdin = STDIN
      in12.close
    end
  end

  describe 'get_category' do
    it 'gives right extension for all categories' do
      in13 = StringIO.new('0')
      $stdin = in13
      expect(Searching.get_category page).to(eq(''))
      $stdin = STDIN
      in13.close
    end

    it 'gives right extension for Community Service/Service Learning category' do
      in14 = StringIO.open do |a|
        a.puts '3'
        a.puts '-1'
        a.string
      end
      $stdin = in14
      expect(Searching.get_category page).to(eq('&m=Community+Service%2fService+Learning'))
      $stdin = STDIN
      in14.close
    end

    it 'gives right extension for Ethnic/Cultural,Governance Organizations, Special Interest categories' do
      in15 = StringIO.open do |a|
        a.puts '6'
        a.puts '11'
        a.puts 'abe0'
        a.puts '5'
        a.puts '-1'
        a.string
      end
      $stdin = in15
      expect(Searching.get_category page).to(eq('&m=Ethnic%2fCultural%3bGovernance+Organizations%3bSpecial+Interest'))
      $stdin = STDIN
      in15.close
    end
  end

  describe 'get_text_type' do
    it 'gives right extension for search type all' do
      in16 = StringIO.new('1')
      $stdin = in16
      expect(Searching.get_text_type page).to(eq('&t=all'))
      $stdin = STDIN
      in16.close
    end

    it 'gives right extension for search type purpose' do
      in17 = StringIO.new('3')
      $stdin = in17
      expect(Searching.get_text_type page).to(eq('&t=purpose'))
      $stdin = STDIN
      in17.close
    end

    it 'gives right extension for search type name' do
      in18 = StringIO.open do |a|
        a.puts 'How are you?'
        a.puts '2'
        a.string
      end
      $stdin = in18
      expect(Searching.get_text_type page).to(eq('&t=name'))
      $stdin = STDIN
      in18.close
    end
  end

  describe 'get_reg_win' do
    it 'gives right extension for all reg windows' do
      in19 = StringIO.new('1')
      $stdin = in19
      expect(Searching.get_reg_win page).to(eq('&ot=0'))
      $stdin = STDIN
      in19.close
    end

    it 'gives right extension for reg window in Spring' do
      in20 = StringIO.new('2')
      $stdin = in20
      expect(Searching.get_reg_win page).to(eq('&ot=1'))
      $stdin = STDIN
      in20.close
    end

    it 'gives right extension for reg window in Autumn' do
      in21 = StringIO.new('3')
      $stdin = in21
      expect(Searching.get_reg_win page).to(eq('&ot=2'))
      $stdin = STDIN
      in21.close
    end

    it 'gives right extension for reg window in Autumn' do
      in22 = StringIO.open do |a|
        a.puts 'Bamboozled'
        a.puts '3'
        a.string
      end
      $stdin = in22
      expect(Searching.get_reg_win page).to(eq('&ot=2'))
      $stdin = STDIN
      in22.close
    end
  end

  describe 'show_inactive_org' do
    it 'gives right extension for showing inactive organizations' do
      in23 = StringIO.new('y')
      $stdin = in23
      expect(Searching.show_inactive_org).to(eq('&a=0'))
      $stdin = STDIN
      in23.close
    end

    it 'gives right extension for showing only active organizations' do
      in24 = StringIO.new('N')
      $stdin = in24
      expect(Searching.show_inactive_org).to(eq('&a=1'))
      $stdin = STDIN
      in24.close
    end

    it 'gives right extension for showing only active organizations' do
      in25 = StringIO.open do |a|
        a.puts 'Kaboom98'
        a.puts 'n'
        a.string
      end
      $stdin = in25
      expect(Searching.show_inactive_org).to(eq('&a=1'))
      $stdin = STDIN
      in25.close
    end
  end
end
