# blogのタイトルを取得するサンプル
require 'mechanize'

url = 'http://blog.inomar.me/'

agent = Mechanize.new
page = agent.get(url)

p page.search('title').inner_text

