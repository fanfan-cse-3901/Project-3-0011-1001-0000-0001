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
      input = StringIO.new('1')
      $stdin = input
      expect (get_campus page).to eq('&c=all')
      $stdin = STDIN
    end

    it 'gives right extension for Lima' do
      input = StringIO.new('3')
      $stdin = input
      expect (get_campus page).to eq('&c=Lima')
      $stdin = STDIN
    end

    it 'gives right extension for Wooster' do
      input = StringIO.new('7')
      $stdin = input
      expect (get_campus page).to eq('&c=Wooster')
      $stdin = STDIN
    end

    it 'gives right extension for Mansfield' do
      input = StringIO.new('8')
      input.puts '4'
      $stdin = input
      expect (get_campus page).to eq('&c=Mansfield')
      $stdin = STDIN
    end
  end

  describe 'get_directory' do
    it 'gives right extension for numbers directory' do
      input = StringIO.new('1')
      $stdin = input
      expect (get_directory page).to eq('&l=1')
      $stdin = STDIN
    end

    it 'gives right extension for S directory' do
      input = StringIO.new('S')
      $stdin = input
      expect (get_directory page).to eq('&l=S')
      $stdin = STDIN
    end

    it 'gives right extension for all directory' do
      input = StringIO.new('0')
      $stdin = input
      expect (get_directory page).to eq('&l=ALL')
      $stdin = STDIN
    end

    it 'gives right extension for F directory' do
      input = StringIO.new('abc')
      input.puts 'f'
      $stdin = input
      expect (get_directory page).to eq('&l=F')
      $stdin = STDIN
    end
  end

  describe 'get_search' do
    it 'gives right extension for search of ab74' do
      input = StringIO.new('ab74')
      $stdin = input
      expect (get_search page).to eq('&s=ab74')
      $stdin = STDIN
    end

    it 'gives right extension for search of Bull\'s eye' do
      input = StringIO.new('Bull\'s eye')
      $stdin = input
      expect (get_search page).to eq('&s=Bull%27s+eye')
      $stdin = STDIN
    end

    it 'gives right extension for search of .\';l\'.;\'4r\\' do
      input = StringIO.new('.\';l\'.;\'4r\\')
      $stdin = input
      expect (get_search page).to eq('&s=.%27%3bl%27.%3b%274r%5c')
      $stdin = STDIN
    end

    it 'gives right extension for search of \n' do
      input = StringIO.new('\n')
      $stdin = input
      expect (get_search page).to eq('')
      $stdin = STDIN
    end
  end

  describe 'get_category' do
    it 'gives right extension for all categories' do
      input = StringIO.new('0')
      $stdin = input
      expect (get_category page).to eq('')
      $stdin = STDIN
    end

    it 'gives right extension for Community Service/Service Learning category' do
      input = StringIO.new('3')
      input.puts '\n'
      $stdin = input
      expect (get_category page).to eq('&m=Community+Service%2fService+Learning')
      $stdin = STDIN
    end

    it 'gives right extension for Ethnic/Cultural,Governance Organizations, Special Interest categories' do
      input = StringIO.new('6')
      input.puts '11'
      input.puts 'abe0'
      input.puts '5'
      input.puts '\n'
      $stdin = input
      expect (get_category page).to eq('&m=Ethnic%2fCultural%3bGovernance+Organizations%3bSpecial+Interest')
      $stdin = STDIN
    end
  end

  describe 'get_text_type' do
    it 'gives right extension for search type all' do
      input = StringIO.new('1')
      $stdin = input
      expect (get_text_type page).to eq('&t=all')
      $stdin = STDIN
    end

    it 'gives right extension for search type purpose' do
      input = StringIO.new('3')
      $stdin = input
      expect (get_text_type page).to eq('&t=purpose')
      $stdin = STDIN
    end

    it 'gives right extension for search type name' do
      input = StringIO.new('How are you?')
      input.puts '2'
      $stdin = input
      expect (get_text_type page).to eq('&t=name')
      $stdin = STDIN
    end
  end

  describe 'get_reg_win' do
    it 'gives right extension for all reg windows' do
      input = StringIO.new('1')
      $stdin = input
      expect (get_reg_win page).to eq('&ot=0')
      $stdin = STDIN
    end

    it 'gives right extension for reg window in Spring' do
      input = StringIO.new('2')
      $stdin = input
      expect (get_reg_win page).to eq('&ot=1')
      $stdin = STDIN
    end

    it 'gives right extension for reg window in Autumn' do
      input = StringIO.new('3')
      $stdin = input
      expect (get_reg_win page).to eq('&ot=2')
      $stdin = STDIN
    end

    it 'gives right extension for reg window in Autumn' do
      input = StringIO.new('Bamboozled')
      input.puts '3'
      $stdin = input
      expect (get_reg_win page).to eq('&ot=2')
      $stdin = STDIN
    end
  end

  describe 'show_inactive_org' do
    it 'gives right extension for showing inactive organizations' do
      input = StringIO.new('y')
      $stdin = input
      expect (show_inactive_org page).to eq('&a=0')
      $stdin = STDIN
    end

    it 'gives right extension for showing only active organizations' do
      input = StringIO.new('N')
      $stdin = input
      expect (show_inactive_org page).to eq('&a=1')
      $stdin = STDIN
    end

    it 'gives right extension for showing only active organizations' do
      input = StringIO.new('Kaboom98')
      input.puts 'n'
      $stdin = input
      expect (show_inactive_org page).to eq('&a=1')
      $stdin = STDIN
    end
  end
end
