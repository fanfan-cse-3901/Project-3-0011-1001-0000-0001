# frozen_string_literal: true

# File created 06/10/2020 by Yifan Yao
# Class Org is a place to store values scraped from web pages.

# Created 06/10/2020 by Yifan Yao
# Edited 06/11/2020 by Amanda Cheng: Defined the structure of Org object with its many attributes
class Org
  attr_reader :id
  attr_accessor :name, :pic_url, :campus, :status, :purpose, :p_leader,
                :s_leader, :t_leader, :advisor, :email, :website, :facebook, :p_type,
                :s_type, :make_up, :constitution, :time_place, :office_location,
                :membership_type, :membership_contact, :new_membership_time, :how_to_apply, :charge_dues

  # Created on 06/10/2020 by Yifan Yao
  # Edited on 06/11/2020 by Amanda Cheng: Added all instance variables
  # Edited on 06/11/2020 by Kevin Dong: Added to_s functionality.
  # Initialize class Org with the unique organization id
  def initialize(org_id)
    @id = org_id
    @campus = 'N/A'
    @status = 'N/A'
    @purpose = 'N/A'  # Purpose Statement
    @p_leader = 'N/A'  # Primary Leader
    @s_leader = 'N/A'  # Secondary Leader
    @t_leader = 'N/A'  # Treasury Leader
    @advisor = 'N/A'
    @email = 'N/A'
    @website = 'N/A'
    @facebook = 'N/A'
    @p_type = 'N/A'  # Primary Type
    @s_type = 'N/A'  # Secondary Type
    @make_up = 'N/A' # Primary Make Up (undergraduate vs graduate)
    @constitution = 'N/A'
    @time_place = 'N/A'
    @office_location = 'N/A'
    @membership_type = 'N/A'
    @membership_contact = 'N/A'
    @new_membership_time = 'N/A'
    @how_to_apply = 'N/A'
    @charge_dues = 'N/A'
  end

  # Created on 06/10/2020 by Kevin Dong
  # To String method
  def to_s
    heading = "#{id}: Url: #{url}, Picture Url: #{pic_url}, Campus: #{campus}, Status: #{status}, Purpose: #{purpose}, "
    people = "Primary Leader: #{p_leader}, Secondary Leader: #{s_leader}, Treasury Leader: #{t_leader}, "
    contact = "Advisor: #{advisor}, Email: #{email}, Website: #{website}, "
    stat1 = "Primary Type: #{p_type}, Secondary Type: #{s_type}, Makeup: #{make_up}, Constitution: #{constitution}, "
    stat2 = "Time and Place: #{time_place}, Office Location: #{office_location}, "
    mem = "Membership Type: #{membership_type}, Membership Contact: #{membership_contact}, New Membership Time: #{
                                                                                                new_membership_time}, "
    app = "How to Apply: #{how_to_apply}, Charge Dues: #{charge_dues}"

    # return string
    heading + people + contact + stat1 + stat2 + mem + app
  end
  public :initialize, :to_s
end
