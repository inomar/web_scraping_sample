require 'open-uri'
require 'nokogiri'

url = 'http://matome.naver.jp/tech'

charset = nil

html = open(url) do |f|
	charset = f.charset
	f.read
end

doc = Nokogiri::HTML.parse(html, nil, charset)

doc.xpath('//li[@class="mdTopMTMList01Item"]').each do |node|

p node.css('h3').inner_text
p node.css('img').attribute('src').value
p node.css('a').attribute('href').value

end
