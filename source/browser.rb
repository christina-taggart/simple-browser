require 'net/http'
require 'nokogiri'
require 'open-uri'
require 'uri'
require 'pry'

require_relative 'util'

class Browser

  def prompt_user
    print "Type your url (ex: http://website.com/): "
    @page = Page.new gets.chomp
  end

  def run!
    puts @page.url
    puts @page.title
    puts @page.links
  end

end


class Page

  def initialize(link)
    @link = link
  end

  def fetch!
    Nokogiri::HTML(open(@link))
  end

  def url
    @link
  end

  def links
    fetch!.css('a').map { |link| link['href'] }.reject { |e| e == '#' }
  end

  def title
    "Title: #{fetch!.css('title').text}"
  end

end


site = Browser.new
site.prompt_user
site.run!
