class Roster
  def initialize(team:, kicker: nil, returner: nil, center: nil, qb: nil, safety: nil)
    @team = team

    @kicker = kicker
    @returner = returner
    @center = center
    @qb = qb
    @safety = safety

    @players = [@kicker, @returner, @center, @qb, safety]
  end

  attr_reader :team, :kicker, :returner, :center, :qb, :safety

  def includes?(player)
    @players.include?(player)
  end
end
