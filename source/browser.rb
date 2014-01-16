require 'net/http'
require 'nokogiri'
require 'open-uri'

require_relative 'util'

class Browser
    def initialize(render,url)
        @page = render.new(url)
    end

  def render_page
    puts "Fetching..."
    puts @page.to_console
  end

  def run!
    render_page
  end

end

new_browser = Browser.new(Page,'http://www.cnn.com/2013/02/06/travel/private-jets/index.html')
new_browser.run!
