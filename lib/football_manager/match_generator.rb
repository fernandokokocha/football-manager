class MatchGenerator
  def initialize(kickoff_generator:, event_generators:)
    @kickoff_generator = kickoff_generator
    @event_generators = event_generators
  end

  attr_reader :kickoff_generator, :event_generators

  def generate(roster_1, roster_2)
    match = Match.new
    30.times do
      action = kickoff_generator.generate(roster_1, roster_2, event_generators)
      match.add_action(action)
    end
    match
  end
end
