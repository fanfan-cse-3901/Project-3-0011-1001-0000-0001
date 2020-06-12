# frozen_string_literal: true

# File created 06/10/2020 by Yifan Yao
# Class Org is a place to store values scraped from web pages.

# Created 06/10/2020 by Yifan Yao
class Org
  attr_reader :id
  attr_accessor :url, :pic_url, :campus, :status, :purpose, :p_leader,
                :s_leader, :t_leader, :advisor, :email, :website, :p_type,
                :s_type, :make_up, :constitution, :time_place, :office_location,
                :membership_type, :membership_contact, :new_membership_time, :how_to_apply, :charge_dues

  # Created 06/10/2020 by Yifan Yao
  # Edited 06/11/2020 by Amanda Cheng: Added all instance variables
  # Initialize class Org with the unique organization id
  def initialize(org_id)
    @id = org_id
    # @campus = 'N/A'
    # @status = 'N/A'
    # @purpose = 'N/A'  # Purpose Statement
    # @p_leader = 'N/A'  # Primary Leader
    # @s_leader = 'N/A'  # Secondary Leader
    # @t_leader = 'N/A'  # Treasury Leader
    # @advisor = 'N/A'
    # @email = 'N/A'
    # @website = 'N/A'
    # @p_type = 'N/A'  # Primary Type
    # @s_type = 'N/A'  # Secondary Type
    # @make_up = 'N/A' # Primary Make Up (undergraduate vs graduate)
    # @constitution = 'N/A'
    # @time_place = 'N/A'
    # @office_location = 'N/A'
    # @membership_type = 'N/A'
    # @membership_contact = 'N/A'
    # @new_membership_time = 'N/A'
    # @how_to_apply = 'N/A'
    # @charge_dues = 'N/A'
  end

  public :initialize
end
