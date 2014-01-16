require 'net/http'
require 'nokogiri'

require_relative 'util'

class Browser
  def run!
    print "url> "
    user_input = gets.chomp
    page = Page.new(user_input)
    display_page_info
  end

  def display_page_info
    puts "Fetching..."
    puts "Title: " + page.title
    puts "Links: "
    page.links.each { |link| puts "  #{link}"  unless link.nil?}
	end
end

Browser.new.run!





