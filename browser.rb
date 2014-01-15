require 'nokogiri'
require 'open-uri'

class Browser
	attr_accessor :has_title, :has_text, :has_links, :has_char_count
	def initialize
		set_default_options
		run_browser
	end

	def get_input 
		puts "WELCOME TO THIS AWESOME BROWSWER!"
		puts "Enter URL to browse or type 'options' for options:"
		puts "Type 'quit' to exit browser"
		print "Type Here: "
		@input = gets.chomp
		Options.new(self) if @input == "options"
		@page = Nokogiri::HTML(open(@input)) if @input != "quit"
	end

	def run_browser
		until @input == "quit"
			get_input
			break if @input == "quit"
			get_info
			display
		end
	end

	def set_default_options
		@has_title = true
		@has_text = true
		@has_links = true
		@has_char_count = true
	end


	def get_info
		get_title
		get_text
		get_links
	end

	def get_title
		@title = @page.css('title').text
	end

	def get_text
		@text = @page.css('body p').text
		@char_count = @text.length
	end

	def get_links
	@links = @page.css('a').map {|link| link.attribute('href').to_s}.uniq.sort.delete_if {|href| href.empty?}
	end

	def display
		p "Title: " + @title if @has_title
		p "Text: " + @text if @has_text
		if @has_links
			puts "Links:"
			puts @links
		end
		p "Character Count: " + @char_count.to_s if @has_char_count
	end

	def enable_title
		@has_title = true
		puts "Title enabled"
	end

	def enable_text
		@has_text = true
		puts "Text enabled"
	end

	def enable_links
		@has_links = true
		puts "Links enabled"
	end

	def enable_char_count
		@has_char_count = true
		puts "Character Count enabled"
	end

	def disable_title
		@has_title = false
		puts "Title disabled"
	end

	def disable_text
		@has_text = false
		puts "Text disabled"
	end

	def disable_links
		@has_links = false
		puts "Links disabled"
	end

	def disable_char_count
		@has_char_count = false
		puts "Character Counr disabled"
	end
end

class Options
	attr_reader :browser
	def initialize(browser)
		@browser = browser
		@input = nil
		run_and_apply
		browser.get_input
	end

	def run_and_apply
		until @input == "return"
			run_options 
			apply_options
		end
	end

	def run_options
		puts "Here are your display options"
		puts "Title"
		puts "Text"
		puts "Links"
		puts "Character Count"
		puts "Type 'enable' plus whatever you want to enable to enable for ex. 'enable Title'"
		puts "type 'disable' plus whatever you want to disable to disable for ex 'disable Text'"
		puts "type 'return' to return to browsing"
		print "Enter Command Here: "
		@input = gets.chomp
	end

	def apply_options
		browser.enable_title if @input == 'enable Title'
		browser.disable_title if @input == 'disable Title'
		browser.enable_text if @input == 'enable Text'
		browser.disable_text if @input == 'disable Text'
		browser.enable_links if @input == 'enable Links'			
		browser.disable_links if @input == 'disable Links'
		browser.enable_char_count if @input == 'enable Character Count'
		browser.disable_char_count if @input == 'disable Character Count'
	end	
end

my_browser = Browser.new













