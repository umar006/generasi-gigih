require_relative 'player'

class Ally < Player
  def initialize(name, hitpoint, att_dmg)
    super(name, hitpoint, att_dmg)
  end

  def take_heal(heal_point)
    @hitpoint += heal_point
  end
end