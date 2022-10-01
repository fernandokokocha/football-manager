class SkillBasedTackleAttemptPhaseGenerator
  def initialize(random_int = nil)
    @random_int = random_int
  end

  def call(roster_offence, roster_defence, current_yards, progress)
    runner = roster_offence.qb
    left_tackle = roster_defence.left_tackle

    runner_adventage = (runner.skills.run - left_tackle.skills.tackle) # -10 to 10, often 0
    base_p = 50
    p = base_p + (runner_adventage * 4)

    r = @random_int ? @random_int : rand(1..100)

    next_phase = (r < p) ? :sprint : :tackle

    TackleAttemptPhase.new(
      ball_holder: runner,
      tackle: left_tackle,
      yards_diff: Yards.new(0),
      next_phase: next_phase,
      time_in_seconds: 2,
    )
  end
end
