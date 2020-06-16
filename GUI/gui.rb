# frozen_string_literal: true

# File created 06/15/2020 by Yifan Yao
# ATTEN: PART OF CODES IN THIS FILE WERE REFERENCED FROM FXRuby - Create Lean and Mean GUIs with Ruby (2008)
#   URL: http://index-of.es/Ruby/FXRuby%20-%20Create%20Lean%20and%20Mean%20GUIs%20with%20Ruby%20(2008).pdf
require 'fox16'
require 'mechanize'
require 'cgi'
require './get_org_list'

include Fox

# Class created 06/15/2020 by Yifan Yao
class Menu < FXMainWindow
  def initialize(app)
    super(app, 'OSU Student Organizations Collector', width: 350, height: 200)

    matrix = FXMatrix.new(self, 2, MATRIX_BY_COLUMNS|LAYOUT_FILL)

    FXLabel.new(matrix, 'Campus: ')
    campus_select = FXListBox.new(matrix,
                           opts: LISTBOX_NORMAL|FRAME_SUNKEN|FRAME_THICK|LAYOUT_FILL_X)
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
        path = "#{dialog.directory}/#{time.year}#{time.month}#{time.day}_#{time.hour}#{time.min}#{time.sec}.csv"
        path_input.text = path
      end
    end

    # Step 3 - promote user to enter search keywords
    FXLabel.new(matrix, 'Keyword: ')
    keyword_input = FXTextField.new(matrix, 30)

    # create progress report
    FXLabel.new(matrix, 'Status')
    status = FXText.new(matrix, opts: LAYOUT_FILL | TEXT_READONLY | TEXT_WORDWRAP)

    # Step 4 - user clicked the button
    submit_button = FXButton.new(matrix, 'Collect')
    submit_button.connect(SEL_COMMAND) do
      selected_campus = campus_arr[campus_select.currentItem]
      keyword = keyword_input.to_s.chomp
      request_url = "https://activities.osu.edu/involvement/student_organizations/find_a_student_org/?v=list&c=#{selected_campus}&s=#{CGI.escape keyword}"
      puts request_url

      # create orgs array
      orgs = []
      get_org_list request_url, orgs

      # output workload
      status.appendText(page.search('//form/div/h3').text.split.join(' '))
      status.appendText('In Progress')

      # output
      status.removeText(0, status.length)
      status.appendText('Success')
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
