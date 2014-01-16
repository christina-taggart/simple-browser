# encoding: UTF-8

require 'net/http'
require 'uri'
require 'nokogiri'

require_relative 'util'

class Browser
  def run!
    puts "Bienvenu(e) au navigateur simple."
    url = ''
    begin
      puts "Donnez-moi un URL:"
      url = gets.chomp
      page = Page.new(url)
      puts "Titre - #{page.title}."
      puts "Voici les liens:"
      page.links.each {|link| puts link}
      puts "URL: #{url}"
      sleep(2.0)
      puts "Voudriez-vous continuer?"
      continue = gets.chomp
    end until continue == "non"
    sleep(1.0)
    puts "Merci, à bientôt!"
  end

end

Browser.new.run!
