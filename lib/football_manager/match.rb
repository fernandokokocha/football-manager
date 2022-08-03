class Match
  def initialize
    @actions = []
  end

  attr_reader :actions
  attr_accessor :ball_possession

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

  def next_action
    return :team_1_kickoff if actions.empty?
    return :team_1_kickoff if actions.last.ends_with_touchdown?
    :team_2_attempt
  end
end
