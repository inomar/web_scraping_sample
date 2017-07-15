# nokogiriを使ってgoogleのtitleを取得するサンプル

require 'open-uri'
require 'nokogiri'

url = 'http://google.com'

charset = nil


doc = Nokogiri::HTML.parse(open(url))

p doc.title
