require_relative 'player'

class Hero < Player
  def initialize(name, hitpoint, att_dmg, heal_point=0, deflect_percentage=0)
    super(name, hitpoint, att_dmg)
    @heal_point = heal_point
    @deflect_percentage = deflect_percentage
  end

  def take_damage(damage)
    if rand < @deflect_percentage
      puts "#{@name} deflect the attack"
      return
    end
    @hitpoint -= damage
  end

  def heal(ally)
    puts "#{@name} heals #{ally.name}, restoring #{@heal_point} hitpoints"
    ally.take_heal(@heal_point)
  end

  def self.heal(hero, allies)
    puts "Which ally you want to heal?"
    unless allies.empty?
      allies.each_with_index do |ally, index|
        puts "#{index + 1}) #{ally.name}"
      end
      ally_to_heal = gets.chomp.to_i - 1

      case ally_to_heal
      when 0
        hero.heal(allies[ally_to_heal]) unless allies[ally_to_heal].die?
      when 1
        hero.heal(allies[ally_to_heal]) unless allies[ally_to_heal].die?
      end
    else
      puts "Your allies already dead!"
    end
  end

  def self.attack(hero, villains)
    puts "Which enemy you want to attack?"  
    villains.each_with_index do |villain, index|
      puts "#{index + 1}) #{villain.name}"
    end
    enemy_to_attack = gets.chomp.to_i - 1
    puts

    case enemy_to_attack
    when 0
      hero.attack(villains[enemy_to_attack])
    when 1
      hero.attack(villains[enemy_to_attack])
    when 2
      hero.attack(villains[enemy_to_attack])
    end
  end
end