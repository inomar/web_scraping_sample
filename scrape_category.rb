require 'nokogiri'
require 'mechanize'

HOST = 'https://ja.wikipedia.org/'.freeze
target = 'wiki/Category:%E5%B0%8F%E8%AA%AC%E3%81%AE%E3%82%B8%E3%83%A3%E3%83%B3%E3%83%AB'

mechanize = Mechanize.new
page = mechanize.get (HOST + target)
html = Nokogiri::HTML(page.body)
html = html.xpath("//div[@class='mw-category']/div[@class='mw-category-group']").map do |node|
  node.search('a').text.split('小説')
end
puts html