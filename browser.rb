require 'net/http'
require 'nokogiri'

class Browser
  def initialize
    prompt_for_url
    @page = Page.new(@url)
    @page.fetch!
    @page.parse_page
    display_page
  end

  def display_page
    puts "Title: #{@page.title}"
    puts "Content-length: #{@page.content_length} characters"
    puts "Links: "
    @page.links.each do |link| 
      puts link['href'] unless 
      (link['href'].nil? || link['href'].match(/^#/)) || link['href'].match(/^javascript/)
    end
  end

  private
  def prompt_for_url
    print "url> "
    @url = gets.chomp
  end
end

class Page
  attr_accessor :url, :title, :content_length, :links
  def initialize(url)
    @url = url
  end

  def fetch!
    uri = URI(@url)
    puts "\nFetching..."
    @html = Net::HTTP.get(uri)
  end

  def parse_page
    @page = Nokogiri::HTML::Document.parse(@html)
    @title = @page.search('title').text
    @content_length = @html.gsub(/<[^>]+>/, '').length
    @links = @page.search('a')
  end
end

# Driver Code
# You must run this program from terminal or it will not run
# Due to using gets.chomp for input
better_than_chrome = Browser.new

# browser.rb core responsibilities
# Concern 1
  # Display a prompt for the user
    # url> http://www.cnn.com/2013/02/06/travel/private-jets/index.html
  # Parse user input into correct format for web page fetching
# Concern 2
  # Fetch a web page
# Concern 3
  # Extract relevant info from web page
  # Display relevant info from web page in a user friendly way