require 'net/http'
require 'nokogiri'
require 'open-uri'

class Page

  def initialize(url)
    @url = fetch(url)
    @title = find_website_title
    @content_length = find_content_length
    @links = find_content_links

  end

  def fetch(url)
    Nokogiri::HTML(open(url)) { |config| config }
  end

  def find_website_title
    @url.search('h1').map { |link| link.inner_text}.join()
  end

  def find_content_length
    @url.search('.cnn_strycntntlft').map { |text| text.inner_text}.to_s.length
  end

  def find_content_links
    @url.search('.cnn_strycntntlft > p > a:first-child').map { |link| link['href'] }.join("\n")
  end

  def to_console
    "Title: #{@title}\nContent Length: #{@content_length}\nLinks:\n#{@links}"
  end

end