class MatchGenerator
  def initialize(kickoff_generator:, event_generators:)
    @kickoff_generator = kickoff_generator
    @event_generators = event_generators
  end

  attr_reader :kickoff_generator, :event_generators

  def generate(roster_1, roster_2)
    match = Match.new
    while (match.time_in_seconds < Rules::QUARTER_TIME_IN_SECONDS)
      action = kickoff_generator.generate(roster_1, roster_2, event_generators)
      match.add_action(action)
    end
    match
  end
end
