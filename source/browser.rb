require 'net/http'
require 'nokogiri'

require_relative 'util'

class Browser
  def run!
    puts "What website would you like to visit? (Please include the http prefix)"
    desired_html = gets.chomp
    puts "Fetching..."
    uri = URI.parse(desired_html)
    http = Net::HTTP.new(uri.host, uri.port)
    response = http.request(Net::HTTP::Get.new(uri.request_uri))
    espn_html = response.body
    espn_html = response = http.request(request)
    require 'pry'; binding.pry
    test_try = Nokogiri::HTML(espn_html)
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

Browser.new.run!