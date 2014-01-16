require 'nokogiri'
require 'open-uri'

class Page
  attr_reader :url, :title, :links

  def initialize(url)
    @url = url
    @title = ""
    @links = []
  end
  
  def fetch!
    document = Nokogiri::HTML(File.read(open(@url)))
    @title = document.search('title')[0].text
    @links = document.search('a').map { |link| link['href'] }
  end
end