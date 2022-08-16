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
    return :home_kickoff if actions.empty?
    return :home_kickoff if actions.last.ends_with_touchdown?
    :away_attempt
  end

  def next_yards
    return YardsInPitch.new(from_left: 35) if actions.empty?
    return YardsInPitch.new(from_left: 35) if actions.last.ends_with_touchdown?
    actions.last.ending_yards
  end
end
