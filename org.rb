# frozen_string_literal: true

# File created 06/10/2020 by Yifan Yao
=begin
Class Org is a place to store values scraped from web pages.
=end

# Created 06/10/2020 by Yifan Yao
class Org
  attr_reader :id

  # Created 06/10/2020 by Yifan Yao
  # Initialize class Org with the unique organization id
  def initialize(org_id)
    @id = org_id
  end

  public :initialize
end
