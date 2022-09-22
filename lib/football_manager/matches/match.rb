class Match
  def initialize(home_roster, away_roster)
    @home_roster = home_roster
    @away_roster = away_roster
    @actions = []
  end

  attr_reader :actions, :home_roster, :away_roster

  def add_action(action)
    actions << action
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
end
