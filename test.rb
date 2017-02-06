require 'kele'
require 'pp'

k = Kele.new('h@yahoo.com', 'passwird')
body= k.get_roadmap(31)
pp k.get_checkpoint(2160)
