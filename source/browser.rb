require 'net/http'
require 'nokogiri'

require_relative 'util'

class Browser
  def run!
    # Run the browser
    # Display a prompt for a user
    # Parse their input
    # Display useful results by instantiating
    #   a new Page and calling methods on it.
    p "Welcome to simple browser! Enter 'exit' to exit the browser"
    p "-----------------------------------------------------------"
    until ((url=prompt_url) == "exit")
      page = Page.new(url)
      puts "URL: #{page.url}"
      page.fetch!
      puts "Title: #{page.title}"
      puts "Links: "
      page.links.each { |link| puts "\t#{link}"}
    end
    
    # Questions:
    #  1. How can a user quit the browser gracefully?
    #  2. How can a user ask for help, i.e., how do they know what commands are available to them?
    #     A: you can send a message if they type 'help' but I think its pretty self-explanatory
  end

  def prompt_url
    p "Enter link: "
    gets.chomp
  end
end

Browser.new.run!