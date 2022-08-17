class MatchGenerator
  def initialize(action_generator:, event_generators:, offence:, defence:)
    @action_generator = action_generator
    @event_generators = event_generators
    @offence = offence
    @defence = defence

    @match = Match.new(offence, defence)
    @match.ball_possession = offence
    @match.next_action = :kickoff
    @match.next_yards = YardsInPitch.new(from_left: 35)
  end

  attr_reader :action_generator, :event_generators, :match, :offence, :defence

  def generate
    starting_yards = YardsInPitch.new(from_left: Rules::KICKOFF_YARDS)
    next_action = :kickoff

    while (match.time_in_seconds < Rules::QUARTER_TIME_IN_SECONDS)
      action = action_generator.generate(offence, defence, starting_yards, next_action, event_generators)
      match.add_action(action)

      match.ball_possession = @offence
      match.next_action = nil # ?
      match.next_yards = action.ending_yards
    end
    match
  end

  def generate_next
    action = action_generator.generate(offence, defence, YardsInPitch.new(from_left: Rules::KICKOFF_YARDS), :kickoff, event_generators)
    match.add_action(action)
    match.ball_possession = offence
    match
  end
end
