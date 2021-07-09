require_relative "player"

class Villain < Player
  def initialize(name, hitpoint, att_dmg, flee_percentage=0)
    super(name, hitpoint, att_dmg)
    @flee_percentage = flee_percentage
    @flee = false
  end

  def take_damage(damage)
    @hitpoint -= damage
    if @hitpoint <= 50
      flee if rand < @flee_percentage
    end
  end

  def flee
    @fled = true
    puts "#{@name} has fled the battlefield with #{@hitpoint} hitpoint left"
  end

  def flee?
    @flee
  end
end