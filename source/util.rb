class Page
  def initialize(url)
    if url == "exit"
      return
    else
      p "Fetching..."
      @url = URI.parse(url)
      @nokogiri = get_nokogiri
      @links = get_links
      run
    end
  end

  def run
    print_title
    get_content_length
    print_links
  end

  def fetch!
    Net::HTTP.get_response(@url)
  end

  def get_nokogiri
    Nokogiri::HTML(fetch!.body)
  end

  def title
   @nokogiri.search("title").inner_text
  end

  def print_title
    puts "Title: #{title}"
  end

  def get_links
    grab_links
    reset
  end

  def grab_links
    @links =@nokogiri.search("a").map{ |link| link['href']}
  end

  def reset
    @links.select! { |link| link if link && link.match(/\//) }
  end

  def print_links
    puts "Links:"
    unless @links == nil
      @links.each{ |link| puts "  #{link}" }
    end
  end

  def get_content_length
    puts "Content length: #{@nokogiri.search('body').inner_text.scan(/[a-z]+|[0-9]+/i).join.length} characters"
  end
end