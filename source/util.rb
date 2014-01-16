class Page
  attr_reader :doc
  def initialize(url)
    @doc = nil
    fetch!(url)
  end
  
  def find!(selector)
    @doc.css(selector).inner_text
  end

  def fetch!(url)
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    html = response.body
    @doc = Nokogiri::HTML(html)
    do_stuff
  end

  def do_stuff # please actually change this name later, it's terrible
    title
    links
  end

  def title
    title = find!('title')
    title
  end

  def text
    main_text = find!('p')
    main_text.gsub!(/\\/, " ")
    puts "Main text:"
    p main_text
  end
  
  def links
    links = []
    @doc.css('a').each {|element| links << element['href']}
    links.compact!
  end

end