class Roster
  def initialize(team:, kicker: nil, returner: nil, center: nil, qb: nil)
    @team = team
    @kicker = kicker
    @returner = returner
    @center = center
    @qb = qb
  end

  attr_reader :team, :kicker, :returner, :center, :qb
end
