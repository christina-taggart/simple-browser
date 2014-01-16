require "net/http"
require "uri"
require "nokogiri"
require 'open-uri'

class Page

  def initialize(url)
    @url = url
  end

  def fetch!
    return @doc  if @doc
    response = open(@url)
    @doc = Nokogiri::HTML(response)
  end

  def title
    fetch!.search('title').inner_text
  end

  def links
    fetch!.css('a').map { |link| link['href'] }.select { |link| link =~ /http/}
  end
end