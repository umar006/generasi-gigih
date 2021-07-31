class WhoLikeIt
  attr_accessor :names, :likes
  def initialize(names=nil, likes=nil)
    @names = []
    @likes = []
  end

  def likes
    if @names.empty?
      return "no one likes this"
    elsif @names.count == 1
      return "#{@names[0]} likes this"
    elsif @names.count < 4
      return "#{@names[..-2].join(', ')} and #{@names[-1]} like this"
    else
      return "#{@names[..1].join(', ')} and #{@names[2..].length} others like this"
    end
  end
end