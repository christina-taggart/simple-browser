require 'net/http'
require 'uri'
require 'nokogiri'

require_relative 'util'

# Listing the Responsibilities

# Start by listing the core responsibilities of your app. Some of these responsibilities include:

# Displaying a prompt for the user
# Parsing user input
# Fetching a web page
# Extracting the relevant information from the web page
# Displaying the relevant information in a user-friendly way
# etc.

# There are more — make sure you list them out! Next, group these responsibilities into "concerns". Prompting a 
# user for input and taking the appropriate action might be one concern, for example. Fetching a URL and returning 
# an easy-to-display data structure might be another.

# Get input from user and parse data
# fetch web page and extract relevant info from page
# display information for user

class Browser
  def run!(url)
    Page.new(url)
    # content = extract_all_main_content(doc)
    # content.each {|section| puts section}
    # Run the browser
    # Display a prompt for a user
    # Parse their input
    # Display useful results by instantiating
    #   a new Page and calling methods on it.
    
    # Questions:
    #  1. How can a user quit the browser gracefully?
    #  2. How can a user ask for help, i.e., how do they know what commands are available to them?
  end

  def extract_title(doc) # looks for class subtext, then the css selector of the first child element in that "sub-tree"
    doc.search('.cnn_storyarea > h1').map { |h1| h1.inner_text}
  end
  def extract_author(doc)
    doc.search('.cnnByline > strong').map { |strong| strong.inner_text}
  end
  #  def extract_timestamp(doc)
  #   doc.search('.cnnstrytmstmp > div').map { |div| div.inner_text}
  # end
  # def extract_all_main_content(doc) # looks for class subtext, then the css selector of the first child element in that "sub-tree"
  #   doc.search('.cnn_strycntntlft > p').map { |paragraph| paragraph.inner_text}
  # end
  # def extract_all_story_text(doc) # looks for class subtext, then the css selector of the first child element in that "sub-tree"
  #   doc.search('.cnn_storypgraphtext > p').map { |paragraph| paragraph.inner_text}
  # end
end

# url = "http://www.cnn.com/2013/02/06/travel/private-jets/index.html"
# puts "Please enter a URL:"
# user_input = gets.chomp
Browser.new.run!(ARGV.first)
# Browser.new.run!(user_input)


# ideal output

# $ ruby browser.rb
# url> http://www.cnn.com/2013/02/06/travel/private-jets/index.html
# Fetching...
# Title: 'Redneck' speed freak buys super-fast jet
# Content length: 10,123 characters
# Links:
#   http://whatever.com/something.html
#   etc..
#   etc..