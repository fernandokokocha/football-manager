class MatchGenerator
  def initialize(action_generator:, home_roster:, away_roster:)
    @action_generator = action_generator
    @home_roster = home_roster
    @away_roster = away_roster
    @match_state = MatchState.new
    @match = Match.new(home_roster, away_roster)
  end

  attr_reader :action_generator, :home_roster, :away_roster, :match, :match_state

  def generate_next
    offence_roster = match_state.team == :home ? home_roster : away_roster
    defence_roster = match_state.team == :home ? away_roster : home_roster
    starting_yards = match_state.ball_yards
    next_phase = match_state.type == :kickoff ? :kickoff : :snap
    starting_progress = match_state.first_down_marker.starting_progress

    action = action_generator.generate(offence_roster, defence_roster, starting_yards, next_phase, starting_progress)

    # I don't trust this part
    if action.ends_with_touchdown_of?(home_roster)
      @match_state.home_touchdown
    elsif action.ends_with_touchdown_of?(away_roster)
      @match_state.away_touchdown
    elsif action.ends_with_tackle_while_possesion_of?(home_roster)
      @match_state.home_possesion_and_tackled(action.ending_yards)
    elsif action.ends_with_tackle_while_possesion_of?(away_roster)
      @match_state.away_possesion_and_tackled(action.ending_yards)
    end

    @match.add_action(action)
  end

  def generate_whole
    while (match.time_in_seconds < Rules::QUARTER_TIME_IN_SECONDS)
      generate_next
    end
  end
end
