class Match
  def initialize
    @actions = []
  end

  attr_reader :actions

  def add_action(action)
    actions << action
  end
end
