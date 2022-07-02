class Roster
  def initialize(team:, kicker:, returner:)
    @team = team
    @kicker = kicker
    @returner = returner
  end

  attr_reader :team, :kicker, :returner
end
