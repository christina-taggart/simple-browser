require 'net/http'
require 'nokogiri'

require_relative 'util'

class Browser

  def run!
    puts "Welcome to Internet Explorer 6!\n"
    puts "The web as you first experienced it. Over dialup. In the 90s."
    print "url> "
    Page.new(gets.chomp)
    # Run the browser
    # Display a prompt for a user
    # Parse their input
    # Display useful results by instantiating
    #   a new Page and calling methods on it.

    # Questions:
    #  1. How can a user quit the browser gracefully?
    #  2. How can a user ask for help, i.e., how do they know what commands are available to them?
  end
end

# page = Page.new('http://www.google.com')
# p page.noko_object

Browser.new.run!