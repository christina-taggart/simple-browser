require 'net/http'
require 'nokogiri'

require "open-uri"

require_relative 'util'

class Browser
    attr_reader :url, :page, :char_count, :link, :webpage
  def initialize(url)
    @url = url
    @page = page
  end

  def run!
    # Run the browser
    get_input
    fetch
    p get_title
    p get_content_length
    p links


    # Display a prompt for a user
    # Parse their input
    # Display useful results by instantiating
    #   a new Page and calling methods on it.

    # Questions:
    #  1. How can a user quit the browser gracefully?
    #  2. How can a user ask for help, i.e., how do they know what commands are available to them?
  end

  def get_input
    puts "Please enter the URL (ex: http://www.website.com) or exit"
    @url = gets.chomp
    raise "exited" if @url == "exit"
  end

  def fetch
    puts "Fetching . . ."
    uri = URI.parse(@url)
    response = Net::HTTP.get_response(uri)
    @page = response.body
    @webpage = Nokogiri::HTML(@page)
  end

  def get_title
    @title = @webpage.css("title").text
    "Title: #{@title}"
  end

  def get_content_length
     @text = @webpage.css('body p').text
     @char_count = @text.length
     "Content length: #{@char_count}"

  end

  def links
    array_of_links = @webpage.search('a')
    just_the_links = array_of_links.map {|link| link['href'] }

  end


end

#Browser.new.run!

test = Browser.new('http://www.google.com')
# test.get_input
# test.fetch
# p test.get_title
# p test.get_content_length
# p test.links
test.run!