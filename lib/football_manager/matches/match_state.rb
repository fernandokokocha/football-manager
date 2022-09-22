class MatchState
  def initialize
    @team = :home
    @type = :kickoff
    @attempt = 0
    @ball_yards = YardsInPitch.new(from_left: 35)
    @first_down_marker = MarkerKickoff.new
    @progress = ProgressCountup.new
  end

  attr_reader :team, :type, :attempt, :ball_yards, :first_down_marker, :progress

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
    tackle(:away, :home, MarkerCountdown, yards)
  end

  def home_possesion_and_tackled(yards)
    tackle(:home, :away, MarkerCountup, yards)
  end

  def debug
    puts "==="
    puts "team #{team}"
    puts "type #{type}"
    puts "attempt #{attempt}"
    puts "ball_yards #{ball_yards}"
    puts "first_down_marker #{first_down_marker}"
    puts "==="
  end

  private

  def tackle(my_team, other_team, marker_class, yards)
    if team == other_team
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
      @team = other_team
      @type = :attempt
      @ball_yards = yards
    else
      @team = my_team
      @type = :attempt
      @ball_yards = yards
    end

    if @attempt == 1
      @first_down_marker = marker_class.new(first_down_yards: ball_yards)
    end
  end
end
