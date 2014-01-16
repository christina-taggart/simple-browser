require 'net/http'
require 'nokogiri'
require 'open-uri'

require_relative 'util'




class Browser

    def initialize
        @url = nil
        @title = nil
        @content_length = nil
        @links = nil
    end

    def run!
        puts "Please type in the URL!!!"
        url_prompt
        parse_input
        puts "Fetching..."
        puts "Title: #{find_website_title}"
        puts "Content Length: #{find_content_length}"
        puts "Links:\n#{find_content_links}"
    end
    # Display a prompt for a user
    def url_prompt
        @input = gets.chomp
    end
    # Parse their input
    def parse_input
        @url = Nokogiri::HTML(open(@input)) do |config|
        config
        end
    end

    def find_website_title
        @title = @url.search('h1').map { |link| link.inner_text}.join()
    end

    def find_content_length
        @content_length = @url.search('.cnn_strycntntlft').map { |text| text.inner_text}.to_s.length
    end

    def find_content_links
        @links = @url.search('.cnn_strycntntlft > p > a:first-child').map { |link| link['href'] }.join("\n")
    end
    # Display useful results by instantiating
    #   a new Page and calling methods on it.

    # Questions:
    #  1. How can a user quit the browser gracefully?
    #  2. How can a user ask for help, i.e., how do they know what commands are available to them?

end

new_browser = Browser.new

new_browser.run!

