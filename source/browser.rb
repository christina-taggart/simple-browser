require 'net/http'
require 'nokogiri'
require 'open-uri'

require_relative 'util'

class Browser
    def initialize(url)
        @page = Page.new(url)
    end

  def render_page
    puts "Fetching..."
    puts "Title: #{@page.title}"
    puts "Content Length: #{@page.content_length}"
    puts "Links:\n#{@page.links}"
  end

  def run!
    render_page
  end

end

new_browser = Browser.new('http://www.cnn.com/2013/02/06/travel/private-jets/index.html')
new_browser.run!
