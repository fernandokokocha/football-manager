class ActionSetup
  def initialize(team:, type:, attempt: 0, ball_yards:)
    @team = team
    @type = type
    @attempt = attempt
    @ball_yards = ball_yards
  end

  attr_reader :team, :type, :attempt, :ball_yards

  def ==(o)
    self.class == o.class &&
      self.team == o.team &&
      self.type == o.type &&
      self.attempt == o.attempt &&
      self.ball_yards == o.ball_yards
  end
end
