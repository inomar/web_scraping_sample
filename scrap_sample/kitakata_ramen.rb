# ラーメンデータベースから喜多方のラーメン店舗を抽出するサンプル

require 'nokogiri'
require 'mechanize'

class ScrapKitakataRamen

attr_accessor :prefecture, :city, :doc, :ramen_urls

HOST = "https://ramendb.supleks.jp".freeze

	def initialize(prefecture, city)
		@prefecture = prefecture
		@city = city
		mechanize = Mechanize.new
		page = mechanize.get get_url
		@doc = Nokogiri::HTML(page.body)
	end

	def get_url(page = 1)
		url = "#{HOST}/search?q=&page=#{page}&state=#{prefecture}&city=#{city.encode}&order=point"
	end

	def get_urls
		urls =[]
		(1..get_page_count.to_i).each do |i|
			urls.push(get_url(i))
		end
		urls
	end

	def get_page_count
		last_page = doc.xpath("//div[@class='pages']/a[@class='page']").last.text
	end

	def set_ramen(doc, ramens)
		doc.xpath("//ul[@id='searched']/li").each do |node|
			node = node.search('h4')
			name = node.text
			link = node.at('a')[:href]
			ramens.push({ name: "#{name}", link: "#{link}"})
		end
	end

	def get_kitakata_ramens
		kitakata_ramen = []
		mechanize = Mechanize.new
		get_urls.each do |url|
			page = mechanize.get url
			set_ramen(Nokogiri::HTML(page.body), kitakata_ramen)
		end
		kitakata_ramen
	end

end

kitakata_ramen = ScrapKitakataRamen.new("fukushima", "喜多方市")
puts kitakata_ramen.get_kitakata_ramens
