require 'net/http'
require 'nokogiri'
require "uri"
require_relative 'util'

class Browser
  def run!
    puts "Please enter a URL"
    url = gets.chomp
    doc = Nokogiri::HTML(open(url))
    page = Page.new(url, doc)

    # Actually makes the HTTP request
    page.fetch!

    # Returns the URL of the underlying page
    puts "------"
    puts "You are visiting #{page.url}"
    puts "Title: #{page.title}"

    # Returns an Array of URLs (as Strings).
    puts "------"
    p page.display_links
  end
end

Browser.new.run!


# http://www.cnn.com/2013/02/06/travel/private-jets/index.html

