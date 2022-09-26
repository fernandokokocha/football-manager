class Match
  def initialize(home_roster, away_roster)
    @home_roster = home_roster
    @away_roster = away_roster
    @actions = []
    @actions_with_state = []
  end

  attr_reader :actions, :actions_with_state, :home_roster, :away_roster

  def add_action(action, state)
    actions << action
    actions_with_state << {
      action: action,
      state: state,
    }
  end

  def score
    scoring_actions = actions.count do |action|
      action.ends_with_touchdown?
    end
    away_score = scoring_actions * Rules::TOUCHDOWN_POINTS
    "0-#{away_score}"
  end

  def time_in_seconds
    actions.map(&:time_in_seconds).inject(0, &:+)
  end

  def debug
    actions.each { |a| a.debug }
  end
end
