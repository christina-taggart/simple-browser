
require_relative 'util'

class Browser
  include Display
  def initialize
    @current_page = Page.new()
    @exit_flag = true
  end
  def run!
    welcome
    run_user_session
    goodbye
  end

  def run_user_session
    while @exit_flag
      print "url> "
        get_current_page
        run_user_input
    end
  end

  def get_current_page
    input = gets.chomp
    if input == 'q'
      @exit_flag = false
      return
    end
    @current_page = Page.new("http://#{input}")
  end

  def run_user_input
    while true && @exit_flag
      options_menu
      input = gets.chomp.downcase
      case input
      when 't'
        display_page_title
      when 'l'
        display_page_links
      when 'h'
        display_page_html
      when 'b'
        break
      else
        puts "Not valid input"
      end
    end
  end

  def display_page_title
    puts "Title: #{@current_page.title}\n"
  end

  def display_page_links
    puts "Links: \n #{@current_page.links}\n"
  end

  def display_page_html
    puts "HTML:\n#{@current_page.html}\n"
  end
end

Browser.new.run!


# Run the browser
    # Display a prompt for a user
    # Parse their input
    # Display useful results by instantiating
    #   a new Page and calling methods on it.

    # Questions:
    #  1. How can a user quit the browser gracefully?
    #  2. How can a user ask for help, i.e., how do they know what commands are available to them?