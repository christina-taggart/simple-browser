require 'net/http'
require 'nokogiri'

class Page

  attr_accessor :html

  def initialize(url = "http://www.alexleishman.com")
    @url = url
    fetch_url
    create_nok_obj
  end

  def fetch_url
    @html = Net::HTTP.get(URI(@url))
  end

  def create_nok_obj
    @nok_obj = Nokogiri::HTML(@html)
  end

  def title
    @nok_obj.css('title').text
  end

  def links
    all_links = @nok_obj.css('a').map { |obj| obj['href'] }
    relative_links = all_links.select { |link| link =~ /^\// || link =~ /#{@url}/ }.uniq.sort
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

    Press 'q' to quit

    eos
  end

  def goodbye
    system('clear')
    puts <<-eos

    Thank you for using our browser. I hope you enjoyed it :)
    eos
  end
end