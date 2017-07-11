require 'mechanize'
require 'nokogiri'


host = "https://forums.aws.amazon.com"
url = "#{host}/rss.jspa"

mechanize = Mechanize.new
page = mechanize.get url

top_category = nil
mid_category = nil

doc = Nokogiri::HTML(page.body)
doc.xpath("//div[@class='jive-table']/table/tbody/tr").each do |node|
	indent_cell = node.xpath("td[@class='jive-first']/table/tbody/tr/td[1]")
	title_cell = node.xpath("td[@class='jive-first']/table/tbody/tr/td[2]")
	title = title_cell.text
	
	if title =~ /^\s*Category\s*:\s*(.+)/
    	if indent_cell.text.length == 3
      		top_category = $1.strip
    	else
     		 mid_category = $1.strip
    	end
	end
	next unless title =~ /^\s*Forum/
	next unless top_category == "Amazon Web Services"
	rsspath = node.xpath("td[@class='jive-last']/div/table/tbody/tr/td[1]/a").attribute("href")
	title.sub!("Forum:","")
  	title.strip!
  	next unless title.length > 0
	puts "#{host}/#{rsspath} #{title}"

end
