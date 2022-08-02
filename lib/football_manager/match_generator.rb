class MatchGenerator
  def initialize(kickoff_generator:, event_generators:)
    @kickoff_generator = kickoff_generator
    @event_generators = event_generators

    @match = Match.new
  end

  attr_reader :kickoff_generator, :event_generators, :match

  def generate(roster_1, roster_2)
    while (match.time_in_seconds < Rules::QUARTER_TIME_IN_SECONDS)
      action = kickoff_generator.generate(roster_1, roster_2, event_generators)
      match.add_action(action)
      match.ball_possession = roster_1
    end
    match
  end

  def generate_next(roster_1, roster_2)
    action = kickoff_generator.generate(roster_1, roster_2, event_generators)
    match.add_action(action)
    match.ball_possession = roster_1
    match
  end
end
