class ActionSetup
  def initialize(team:, type:, ball_yards:)
    @team = team
    @type = type
    @ball_yards = ball_yards
  end

  attr_reader :team, :type, :ball_yards

  def ==(o)
    self.class == o.class &&
      self.team == o.team &&
      self.type == o.type &&
      self.ball_yards == o.ball_yards
  end
end
