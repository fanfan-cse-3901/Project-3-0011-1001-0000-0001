# frozen_string_literal: true

# This module provides recommendations to users with other organizations from a related category in some situations.
# Has method get_rec.
# Created on 06/17/2020 by Prachiti Garge

require 'mechanize'
require 'cgi'
require './get_org_list'

# Module Recommendations has the methods to form the recommendation array
module Recommendations
  # This method is called from main to get recommendation array with at most 6 recommendations from related categories
  # Returns empty array if all categories were selected in the first place
  #
  # orgs - Array of hashes of organizations
  #
  # Created on 06/17/2020 by Prachiti Garge
  def self.get_rec url_from_bs, orgs
    ret_arr = []
    # If no m= portion, don't provide any recommendations
    return ret_arr if /&m=/.match(url_from_bs).to_s.empty? || orgs.empty?

    # Else
    # Clusters of categories
    cluster1 = ['Academic/College', 'Technology', 'Graduate', 'Professional', 'Undergraduate', 'Honoraries/Honor Societies']
    cluster2 = ['Awareness/Activism', 'Community Service/Service Learning', 'Ethnic/Cultural', 'Governance Organizations', 'Religious/Spiritual', 'Social Fraternities/Sororities']
    cluster3 = ['Creative and Performing Arts', 'Media, Journalism, and Creative Writing', 'Sports and Recreation', 'Special Interest']

    # Get random org
    rand_org = orgs.sample
    category = rand_org['Types'][0]
    category1 = ''
    category2 = ''
    # Get two related categories from appropriate cluster
    if cluster1.include? category
      cluster1.delete category
      category1 = cluster1.delete (cluster1.sample)
      category2 = cluster1.delete (cluster1.sample)
    elsif cluster2.include? category
      cluster2.delete category
      category1 = cluster2.delete (cluster2.sample)
      category2 = cluster2.delete (cluster2.sample)
    else
      cluster3.delete category
      category1 = cluster3.delete (cluster3.sample)
      category2 = cluster3.delete (cluster3.sample)
    end
    # Get the org lists for the two other categories
    page_url1 = "https://activities.osu.edu/involvement/student_organizations/find_a_student_org/
      ?v=list&m=#{CGI.escape category1}"
    new_org1 = Recommendations.get_org_list_modified page_url1

    page_url2 = "https://activities.osu.edu/involvement/student_organizations/find_a_student_org/
      ?v=list&m=#{CGI.escape category2}"
    new_org2 = Recommendations.get_org_list_modified page_url2

    # Get arrays of ids and Remove organizations that are present in the orgs array
    ids_in_orgs = []
    orgs.each do |x|
      ids_in_orgs.push orgs[x].key('id')
    end
    ids_in_new_org1 = []
    new_org1.each do |y|
      ids_in_new_org1.push(new_org1[y][0]) unless ids_in_orgs.include? new_org1[y][0]
    end
    ids_in_new_org2 = []
    new_org1.each do |z|
      ids_in_new_org2.push(new_org2[z][0]) unless (ids_in_orgs.include? new_org2[z][0]) || (ids_in_new_org1.include? new_org2[z][0])
    end

    # Push to pre_rec_arr
    pre_rec_arr = ''
    ids_to_get = (ids_in_new_org1.push ids_in_new_org2).uniq!
    new_org1.each do |i|
      pre_ret_arr.push(new_org1[i]) if ids_to_get.include? new_org1[i][0]
    end
    new_org2.each do |j|
      pre_ret_arr.push(new_org2[j][0]) if ids_in_orgs.include? new_org2[j][0]
    end

    pre_ret_arr.shuffle

    # Return the final array with at most 6 recommendations
    (0...pre_ret_arr.length).each do |a|
      ret_arr.push [pre_ret_arr[a][1],pre_ret_arr[a][2]]
      break if a >= 5
    end
    ret_arr
  end

  # Modified version of get_org_list for the purposes of this module
  # Originally created on 06/10/2020 by Yifan Yao
  # Modified on 06/17/2020 by Prachiti Garge
  # Returns an array of at most 20 arrays with org_id, org_name,org_url
  def self.get_org_list_modified url
    ret_arr = []
    agent1 = Mechanize.new
    page = agent1.get url
    val = 0
    # Yifan's code here
    page.links.each do |link|
      current_id = /[a-z0-9]{8}-[a-z0-9]{4}-[a-z0-9]{4}-[a-z0-9]{4}-[a-z0-9]{12}/.match(link.href).to_s
      unless current_id.empty?
        ret_arr.push [current_id, '', '']
        val += 1
      end
      # Only gets at most 20 orgs
      break if val > 19
    end

    # Create for loop to insert names and urls from ids
    ret_arr.each do |i|
      new_url = "https://activities.osu.edu/involvement/student_organizations/find_a_student_org?i=#{ret_arr[i][0]}"
      page = agent1.get new_url
      ret_arr[i][1] = page.search('//div/h4').text
      ret_arr[i][2] = new_url
    end

    # Return array
    ret_arr
  end

end
