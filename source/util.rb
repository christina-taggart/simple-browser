require "net/http"
require "uri"
require 'nokogiri'
require 'open-uri'


class Page

  attr_accessor :url
  attr_reader :title

  def initialize(url, doc)
    @url = url
    @doc = doc
    @uri = URI.parse(@url)
    @link_list = gather_links
    @title = get_title[0]
  end

  def fetch!
    @http = Net::HTTP.new(@uri.host, @uri.port)
    @response = @http.request(Net::HTTP::Get.new(@uri.request_uri))
    p @response
  end

  def get_title
    @doc.search('.cnn_storyarea h1').map do |element|
      element.inner_text
    end
  end

  def display_title
    puts @title[0]
  end

  def gather_links
    @doc.search('.cnn_storypgraphtxt > a').map do |element|
      element['href']
    end
  end

  def display_links
    puts "This page contains the following links:"
    @link_list.each {|link| puts link}
  end
end


#---------------------------------------------------------------------------






