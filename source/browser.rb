require 'net/http'
require 'nokogiri'

require_relative 'util'

class Browser
  def run!
    splash_page
    while true
      puts "Enter address (http://example.com/) or 'exit': "
      input = gets.chomp
      break if input == "exit"
      puts "Fetching..."
      html = fetch_page(input)
      current_page = Page.new(html)
      current_page.display
    end
  end

  def fetch_page(address)
    uri = URI.parse(address)
    http = Net::HTTP.new(uri.host, uri.port)
    response = http.request(Net::HTTP::Get.new(uri.request_uri))
    html = response.body
  end

  def splash_page
    puts  ".S_sSSs     .S       S.    .S_SsS_S.    .S_SSSs      sSSs    sSSs  sdSS_SSSSSSbs         .S_SSSs     .S_sSSs      sSSs_sSSs     .S     S.     sSSs    sSSs   .S_sSSs
.SS~YS%%b   .SS       SS.  .SS~S*S~SS.  .SS~SSSSS    d%%SP   d%%SP  YSSS~S%SSSSSP        .SS~SSSSS   .SS~YS%%b    d%%SP~YS%%b   .SS     SS.   d%%SP   d%%SP  .SS~YS%%b
S%S   `S%b  S%S       S%S  S%S `Y' S%S  S%S   SSSS  d%S'    d%S'         S%S             S%S   SSSS  S%S   `S%b  d%S'     `S%b  S%S     S%S  d%S'    d%S'    S%S   `S%b
S%S    S%S  S%S       S%S  S%S     S%S  S%S    S%S  S%S     S%|          S%S             S%S    S%S  S%S    S%S  S%S       S%S  S%S     S%S  S%|     S%S     S%S    S%S
S%S    S&S  S&S       S&S  S%S     S%S  S%S SSSS%P  S&S     S&S          S&S             S%S SSSS%P  S%S    d*S  S&S       S&S  S%S     S%S  S&S     S&S     S%S    d*S
S&S    S&S  S&S       S&S  S&S     S&S  S&S  SSSY   S&S_Ss  Y&Ss         S&S             S&S  SSSY   S&S   .S*S  S&S       S&S  S&S     S&S  Y&Ss    S&S_Ss  S&S   .S*S
S&S    S&S  S&S       S&S  S&S     S&S  S&S    S&S  S&S~SP  `S&&S        S&S             S&S    S&S  S&S_sdSSS   S&S       S&S  S&S     S&S  `S&&S   S&S~SP  S&S_sdSSS
S&S    S&S  S&S       S&S  S&S     S&S  S&S    S&S  S&S       `S*S       S&S             S&S    S&S  S&S~YSY%b   S&S       S&S  S&S     S&S    `S*S  S&S     S&S~YSY%b
S*S    d*S  S*b       d*S  S*S     S*S  S*S    S&S  S*b        l*S       S*S             S*S    S&S  S*S   `S%b  S*b       d*S  S*S     S*S     l*S  S*b     S*S   `S%b
S*S   .S*S  S*S.     .S*S  S*S     S*S  S*S    S*S  S*S.      .S*P       S*S             S*S    S*S  S*S    S%S  S*S.     .S*S  S*S  .  S*S    .S*P  S*S.    S*S    S%S
S*S_sdSSS    SSSbs_sdSSS   S*S     S*S  S*S SSSSP    SSSbs  sSS*S        S*S             S*S SSSSP   S*S    S&S   SSSbs_sdSSS   S*S_sSs_S*S  sSS*S    SSSbs  S*S    S&S
SSS~YSSY      YSSP~YSSY    SSS     S*S  S*S  SSY      YSSP  YSS'         S*S             S*S  SSY    S*S    SSS    YSSP~YSSY    SSS~SSS~S*S  YSS'      YSSP  S*S    SSS
                                   SP   SP                               SP              SP          SP                                                      SP
                                   Y    Y                                Y               Y           Y                                                       Y"

  puts
  puts "----------(C) DAVID GOODMAN & JOHN OLMSTED, 2014----------"
  puts
  end
end


class Page
  def initialize(html)
    @page_nokigiri = Nokogiri::HTML(html)
  end

  def title
    @page_nokigiri.title
  end

  def links
    @page_nokigiri.search('a').map { |link| link['href'] }
  end

  def paragraphs
    @page_nokigiri.search('p').map { |paragraph| paragraph.inner_text }
  end

  def display
    puts
    puts "---------------------------------------------------------"
    puts title
    puts
    puts "---LINKS---"
    links.each { |link| puts link }
    puts
    puts "---TEXT---"
    paragraphs.each do |paragraph|
      puts paragraph
      puts
    end
    puts "---------------------------------------------------------"
  end
end


#-----DRIVERS
runit = Browser.new
runit.run!


# uri = URI.parse("http://espn.go.com/")
# http = Net::HTTP.new(uri.host, uri.port)
# response = http.request(Net::HTTP::Get.new(uri.request_uri))
# html = response.body
# test_page = Page.new(html)

# p test_page.title
# p test_page.links
# p test_page.paragraphs

# test_page.display