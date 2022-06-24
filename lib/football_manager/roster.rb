class Roster
  def initialize(team: nil, kicker: nil)
    @team = team
    @kicker = kicker
  end

  attr_reader :team, :kicker
end
