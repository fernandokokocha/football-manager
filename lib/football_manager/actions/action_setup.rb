class ActionSetup
  def initialize(team:, type:, attempt: 0, ball_yards:, first_down_marker:)
    @team = team
    @type = type
    @attempt = attempt
    @ball_yards = ball_yards
    @first_down_marker = first_down_marker
  end

  attr_reader :team, :type, :attempt, :ball_yards, :first_down_marker

  def ==(o)
    self.class == o.class &&
      self.team == o.team &&
      self.type == o.type &&
      self.attempt == o.attempt &&
      self.ball_yards == o.ball_yards &&
      self.first_down_marker == o.first_down_marker
  end
end
