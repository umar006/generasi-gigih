require_relative 'player'

jin_sakai = Player.new("Jin Sakai", 100, 50, 8)
khotun_khan = Player.new("Khotun Khan", 500, 50)
puts jin_sakai
puts khotun_khan

 
loop do
  puts
  jin_sakai.attack(khotun_khan)
  puts khotun_khan
  break if khotun_khan.die?

  puts
  khotun_khan.attack(jin_sakai)
  puts jin_sakai
  break if jin_sakai.die?
end
