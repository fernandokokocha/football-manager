class MatchState
  def initialize
    @team = :home
    @type = :kickoff
    @attempt = 0
    @ball_yards = YardsInPitch.new(from_left: 35)
    @first_down_marker = PseudomarkerKickoffHome.new
    # @progress = ProgressCountup.new
  end

  attr_reader :team, :type, :attempt, :ball_yards, :first_down_marker, :progress

  def next_action_setup
    ActionSetup.new(
      team: team,
      type: type,
      attempt: attempt,
      ball_yards: ball_yards,
      progress: first_down_marker.starting_progress,
    )
  end

  def away_touchdown
    @team = :away
    @type = :kickoff
    @attempt = 0
    @ball_yards = YardsInPitch.new(from_right: 35)
    @first_down_marker = PseudomarkerKickoffAway.new
    # @progress = ProgressCountdown.new
  end

  def home_touchdown
    @team = :home
    @type = :kickoff
    @attempt = 0
    @ball_yards = YardsInPitch.new(from_left: 35)
    @first_down_marker = PseudomarkerKickoffHome.new
    # @progress = ProgressCountup.new
  end

  def away_possesion_and_tackled(yards)
    tackle(:away, :home, MarkerCountdown, MarkerCountup, yards)
  end

  def home_possesion_and_tackled(yards)
    tackle(:home, :away, MarkerCountup, MarkerCountdown, yards)
  end

  def debug
    puts "==="
    puts "team #{team}"
    puts "type #{type}"
    puts "attempt #{attempt}"
    puts "ball_yards #{ball_yards.from_left}"
    puts "first_down_marker #{first_down_marker.class} #{first_down_marker.first_down_yards} #{first_down_marker.target}"
    puts "progress #{first_down_marker.starting_progress}"
    puts "==="
  end

  private

  def tackle(my_team, other_team, marker_class, other_marker_class, yards)
    if team == other_team
      @attempt = 1
      @first_down_marker = marker_class.new(first_down_yards: yards)
    else
      if @first_down_marker && @first_down_marker.crossed?(yards)
        @attempt = 1
        @first_down_marker = marker_class.new(first_down_yards: yards)
      else
        @attempt += 1
        @first_down_marker = marker_class.new(first_down_yards: yards)
      end
    end

    if (@attempt > 4)
      @attempt = 1
      @team = other_team
      @type = :attempt
      @ball_yards = yards
      @first_down_marker = other_marker_class.new(first_down_yards: ball_yards)
    else
      @team = my_team
      @type = :attempt
      @ball_yards = yards
    end
  end
end
