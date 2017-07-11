require 'open-uri'
require 'nokogiri'

url = 'http://google.com'

charset = nil

html = open(url) do |f|
	charset = f.charset
	f.read
end

doc = Nokogiri::HTML.parse(html, nil, charset)

p doc.title
