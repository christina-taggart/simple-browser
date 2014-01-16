require 'net/http'
require 'nokogiri'

require_relative 'util'

class Browser
  def run!
    input = ""
    p "Enter your URL to browse. Type 'exit' to close"
    while input != "exit"
      print "url> "
      input = gets.chomp
      Page.new(input)
    end
  end
end

Browser.new.run!