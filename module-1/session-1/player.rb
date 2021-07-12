class Player
  attr_reader :name

  def initialize(name, hitpoint, att_dmg, deflect=0)
    @name = name
    @hitpoint = hitpoint
    @att_dmg = att_dmg
    @deflect = deflect
  end

  def attack(other_player)
    puts "#{@name} attack #{other_player.name} with #{@att_dmg} points"
    other_player.take_damage(@att_dmg)
  end

  def take_damage(damage)
    is_deflect = Random.new.rand(1..10) <= @deflect
    if @deflect > 0 && is_deflect
      puts "#{@name} deflect the attack"
      return
    end
    @hitpoint -= damage
  end

  def die?
    if @hitpoint <= 0
      puts "\n#{@name} dies"
      true
    end
  end

  def to_s
    "#{@name} has #{@hitpoint} hitpoint and #{@att_dmg} attack damage"
  end

end
