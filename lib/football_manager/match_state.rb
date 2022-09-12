class MatchState
  def initialize
    @team = :home
    @type = :kickoff
    @attempt = 0
    @ball_yards = YardsInPitch.new(from_left: 35)
    @first_down_marker = nil
  end

  attr_reader :team, :type, :attempt, :ball_yards, :first_down_marker

  def next_action_setup
    ActionSetup.new(
      team: team,
      type: type,
      attempt: attempt,
      ball_yards: ball_yards,
    )
  end

  def away_touchdown
    @team = :home
    @attemppt = 0
    @ball_yards = YardsInPitch.new(from_left: 35)
  end

  def home_touchdown
    @team = :away
    @attemppt = 0
    @ball_yards = YardsInPitch.new(from_right: 35)
  end

  def away_possesion_and_tackled(yards)
    @attempt += 1

    if (@attempt > 4)
      @attempt = 1
      @team = :home
      @type = :attempt
      @ball_yards = yards
    else
      @team = :away
      @type = :attempt
      @ball_yards = yards
    end

    if @attempt == 1
      @first_down_marker = ball_yards.from_left - 10
    end
  end

  def home_possesion_and_tackled(yards)
    @attempt += 1

    if (@attempt > 4)
      @attempt = 1
      @team = :away
      @type = :attempt
      @ball_yards = yards
    else
      @team = :home
      @type = :attempt
      @ball_yards = yards
    end

    if @attempt == 1
      @first_down_marker = ball_yards.from_left + 10
    end
  end
end
