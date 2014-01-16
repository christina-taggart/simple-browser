require 'net/http'
require 'nokogiri'

class Browser
  def initialize
    prompt_for_url
    fetch_page
    parse_page
    display_page
  end

  def display_page
    puts "Title: #{@title}"
    puts "Content-length: #{@content_length} characters"
    puts "Links: "
    @links.each do |link| 
      puts link['href'] unless 
      (link['href'].nil? || link['href'].match(/^#/)) || link['href'].match(/^javascript/)
    end
  end

  private
  def prompt_for_url
    print "url> "
    # TODO: find out why HTTPS websites dont work....
    @url = gets.chomp
  end

  def fetch_page
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