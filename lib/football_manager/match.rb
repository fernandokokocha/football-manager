class Match
  def initialize
    @actions = []
  end

  attr_reader :actions

  def add_action(action)
    actions << action
  end

  def score
    "0-180"
  end

  def time_in_seconds
    actions.map(&:time_in_seconds).inject(0, &:+)
  end
end
