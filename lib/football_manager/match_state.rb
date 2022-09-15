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
    @team = :away
    @type = :kickoff
    @attempt = 0
    @ball_yards = YardsInPitch.new(from_right: 35)
  end

  def home_touchdown
    @team = :home
    @type = :kickoff
    @attempt = 0
    @ball_yards = YardsInPitch.new(from_left: 35)
  end

  def away_possesion_and_tackled(yards)
    if @team == :home
      @attempt = 1
    else
      if @first_down_marker && @first_down_marker.crossed?(yards)
        @attempt = 1
      else
        @attempt += 1
      end
    end

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
      @first_down_marker = MarkerCountdown.new(first_down_yards: ball_yards)
    end
  end

  def home_possesion_and_tackled(yards)
    if team == :away
      @attempt = 1
    else
      if @first_down_marker && @first_down_marker.crossed?(yards)
        @attempt = 1
      else
        @attempt += 1
      end
    end

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
      @first_down_marker = MarkerCountup.new(first_down_yards: ball_yards)
    end
  end
end
