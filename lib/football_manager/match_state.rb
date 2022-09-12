class MatchState
  def initialize
    @team = :home
    @type = :kickoff
    @ball_yards_num = 35
  end

  attr_accessor :team, :type, :ball_yards_num

  def next_action_setup
    ActionSetup.new(
      team: team,
      type: type,
      ball_yards: YardsInPitch.new(from_left: ball_yards_num),
    )
  end

  def away_touchdown
    @team = :home
    @ball_yards_num = 35
  end

  def home_touchdown
    @team = :away
    @ball_yards_num = 65
  end
end
