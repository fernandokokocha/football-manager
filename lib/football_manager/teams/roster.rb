class Roster
  def initialize(team:, kicker: nil, returner: nil, center: nil, qb: nil, safety: nil, left_tackle: nil)
    @team = team

    @kicker = kicker
    @returner = returner
    @center = center
    @qb = qb
    @safety = safety
    @left_tackle = left_tackle

    @players = [@kicker, @returner, @center, @qb, safety, @left_tackle]
  end

  attr_reader :team, :kicker, :returner, :center, :qb, :safety, :left_tackle

  def includes?(player)
    @players.include?(player)
  end
end
