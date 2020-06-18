# frozen_string_literal: true

# File created 06/15/2020 by Yifan Yao
# ATTEN: PART OF CODES IN THIS FILE WERE REFERENCED FROM FXRuby - Create Lean and Mean GUIs with Ruby (2008)
#   URL: http://index-of.es/Ruby/FXRuby%20-%20Create%20Lean%20and%20Mean%20GUIs%20with%20Ruby%20(2008).pdf
require 'fox16'
require 'mechanize'
require 'cgi'
require 'json'
require './get_org_list'

include Fox

# Class created 06/15/2020 by Yifan Yao
# Edited 06/17/2020 by Yifan Yao: Complete file output, provide more details for scrapping progress
class Menu < FXMainWindow
  def initialize(app)
    super(app, 'OSU Student Organizations Collector', width: 380, height: 200)

    matrix = FXMatrix.new(self, 2, MATRIX_BY_COLUMNS | LAYOUT_FILL)

    FXLabel.new(matrix, 'Campus: ')
    campus_select = FXListBox.new(matrix,
                                  opts: LISTBOX_NORMAL | FRAME_SUNKEN | FRAME_THICK | LAYOUT_FILL_X)
    campus_select.numVisible = 5

    # Step 1 - get the list of OSU campus
    agent = Mechanize.new
    page = agent.get 'https://activities.osu.edu/involvement/student_organizations/find_a_student_org/?v=list'
    list = page.search '//div/select/option'
    campus_arr = []
    list.each do |i|
      campus_arr.push i.text.split.join(' ')
    end
    campus_arr.each do |i|
      campus_select.appendItem(i)
    end

    # Step 2 - promote user to select path
    open_dir_btn = FXButton.new(matrix, 'Save To: ', opts: BUTTON_NORMAL)
    path_input = FXTextField.new(matrix, 30)
    path = nil
    open_dir_btn.connect(SEL_COMMAND) do
      dialog = FXDirDialog.new(matrix, 'Choose Directory')
      if dialog.execute != 0
        time = Time.new
        path = "#{dialog.directory}/#{time.year}#{time.month}#{time.day}_#{time.hour}#{time.min}#{time.sec}.json"
        path_input.text = path
      end
    end

    # Step 3 - promote user to enter search keywords
    FXLabel.new(matrix, 'Keyword: ')
    keyword_input = FXTextField.new(matrix, 30)

    # create progress report
    FXLabel.new(matrix, 'Status')
    status = FXText.new(matrix, opts: LAYOUT_FILL | TEXT_READONLY | TEXT_WORDWRAP)

    # Step 3.5 - find orgs
    pre_submit_button = FXButton.new(matrix, 'Find orgs')
    pre_submit_button.connect(SEL_COMMAND) do
      selected_campus = campus_arr[campus_select.currentItem]
      keyword = keyword_input.to_s.chomp
      request_url = "https://activities.osu.edu/involvement/student_organizations/find_a_student_org/?v=list&c=#{selected_campus}&s=#{CGI.escape keyword}"

      agent = Mechanize.new
      page = agent.get request_url

      status.removeText(0, status.length)
      status.appendText("#{page.search('//form/div/h3').text.split.join(' ')}, click \"Save to JSON\" to get details.")
    end

    # Step 4 - user clicked the button
    submit_button = FXButton.new(matrix, 'Save to JSON')
    submit_button.connect(SEL_COMMAND) do
      selected_campus = campus_arr[campus_select.currentItem]
      keyword = keyword_input.to_s.chomp
      request_url = "https://activities.osu.edu/involvement/student_organizations/find_a_student_org/?v=list&c=#{selected_campus}&s=#{CGI.escape keyword}"
      puts request_url

      # create orgs array
      orgs = []
      get_org_list request_url, orgs
      counter = 0

      orgs.each do |org|
        agent = Mechanize.new
        page = agent.get "https://activities.osu.edu/involvement/student_organizations/find_a_student_org?i=#{org['id']}"

        # get values from form via XPath
        name = page.search('//div/h4')
        table = page.search('//form/div/table/tr')

        # print progress in console
        puts "In Progress(#{counter}/#{orgs.length})" if (counter % 15).zero?

        # store into name org pair
        org['Name'] = name.text
        # delete attribute Types
        org.delete('Types')

        # partial code from Kevin's get_org_data.rb w/o attr
        (0...table.length).each do |i|
          combo = table[i].text.split(':')
          key = combo[0].strip
          if ['Facebook Group Page', 'Website'].include? key
            link = combo[1...combo.length]
            value = link.reduce { |whole, seg| whole.strip + ':' + seg.strip }
          else
            value = combo[1].strip
          end

          org[key] = value.strip
        end
        counter += 1
      end

      # JSON file output
      path = path_input.text
      File.open(path, 'w') do |line|
        line.puts orgs.to_json
      end

      # output success message
      puts "Done: #{counter}/#{orgs.length}"
      status.removeText(0, status.length)
      status.appendText("File Saved to #{path}")
    end
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end
end

if __FILE__ == $PROGRAM_NAME
  FXApp.new do |app|
    Menu.new(app)
    app.create
    app.run
  end
end
