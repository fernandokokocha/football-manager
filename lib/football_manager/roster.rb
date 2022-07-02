class Roster
  def initialize(team:, kicker:)
    @team = team
    @kicker = kicker
  end

  attr_reader :team, :kicker
end
