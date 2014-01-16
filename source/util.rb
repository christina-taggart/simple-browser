require 'net/http'
require 'nokogiri'

class Page
  attr_accessor :title, :links, :html, :nok_obj
  def initialize(url = "http://www.alexleishman.com")
    @url = url
    @html = ""
    fetch!
  end

  def fetch!
    @html = Net::HTTP.get(URI(@url))
    @nok_obj = Nokogiri::HTML(@html)
  end

  def title
    @nok_obj.css('title').text
  end

  def links
    all_links = @nok_obj.css('a').map { |obj| obj['href'] }
    relative_links = all_links.select { |link| link =~ /^\// }
  end

end

module Display
  def options_menu
    puts <<-eos
    Options       Description
      l      |     Show links on page
      t      |     Show page title
      h      |     Show page html
      b      |     Go back
    eos
  end

  def welcome
    puts <<-eos
    Welcome to the world's best web browser. This browser is much better than Chrome, Firefox and IE combined.
    Use at your own risk, don't be overwhelmed by the awesomeness!!!

    Created by Leishman Industries, Inc.
    Copyright 2014
    eos
  end

  def goodbye
    puts <<-eos
    Thank you for using our browser. I hope you enjoyed it :)
    eos
  end
end