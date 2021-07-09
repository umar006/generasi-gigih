require_relative 'hero'
require_relative 'ally'
require_relative 'villain'
require_relative 'mongol_archer'
require_relative 'mongol_spearman'
require_relative 'mongol_swordsman'

jin_sakai = Hero.new('Jin Sakai', 100, 50, 20, 0.8)

yuna = Ally.new("Yuna", 90, 45)
sensei_ishikawa = Ally.new("Sensei Ishikawa", 80, 60)
allies = [yuna, sensei_ishikawa]

mongol_archer = MongolArcher.new("Mongol Archer", 80, 40, 0.5)
mongol_spearman = MongolSpearman.new("Mongol Spearman", 120, 60, 0.5)
mongol_swordsman = MongolSwordsman.new("Mongol Swordsman", 100, 50, 0.5)
villains = [mongol_archer, mongol_spearman, mongol_swordsman]

i = 1
until jin_sakai.die? || villains.empty? do
  puts "============ Turn #{i} =============="
  puts

  puts jin_sakai
  allies.each do |allie|
    puts allie
  end
  puts

  villains.each do |villain|
    puts villain
  end
  puts

  puts "As #{jin_sakai.name}, what do you want to do this turn?"
  puts "1) Attack an enemy"
  puts "2) Heal an ally"
  what_to_do = gets.chomp
  puts 

  case what_to_do
  when "1"
    Hero.attack(jin_sakai, villains)
  when "2"
    Hero.heal(jin_sakai, allies)
  end
  allies.each{|ally| ally.attack(villains[rand(villains.size)])}
  puts

  villains.each do |villain|
    villain.attack(allies[rand(allies.size)])
  end
  puts

  villains.delete_if{|villain| villain.die? || villain.flee?}
  allies.delete_if{|ally| ally.die?}

  i += 1
end
