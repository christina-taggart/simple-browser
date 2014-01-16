

class Page
  attr_reader :url, :noko_object, :links

  def initialize(url)
    puts "Fetching..."
    @url = URI.parse(url)
    @noko_object = convert_to_noko
    @links = get_links
    run
  end

  def run
    print_title
    get_content_length
    print_links
  end

  def fetch!
    Net::HTTP.get_response(url)
  end

  def convert_to_noko
    Nokogiri::HTML(fetch!.body)
  end

  def title
    noko_object.search("title").inner_text
  end

  def print_title
    puts "Title: #{title}"
  end

  def get_links
    fetch_links
    clean_links
    # Research alert!
    # How do you use Nokogiri to extract all the link URLs on a page?
    #
    # These should only be URLs that look like
    #   <a href="http://somesite.com/page.html">Click here!</a>
    # This would pull out "http://somesite.com/page.html"
  end

  def fetch_links
    @links = noko_object.search("a").map{ |link| link['href']}
  end

  def clean_links
    @links.select! { |link| link if link && link.match(/\//) }
  end

  def print_links
    puts "Links:"
    @links.each{ |link| puts "  #{link}" }
  end

  def get_content_length
    puts "Content length: #{@noko_object.search('body').inner_text.scan(/[a-z]+|[0-9]+/i).join.length} characters"
  end
end