require_relative 'villain'

class MongolSpearman < Villain
  def attack(other_player)
    puts "#{@name} shoots an arrow at #{other_player.name} with #{@att_dmg} damage"
    other_player.take_damage(@att_dmg)
  end
end
