class DebugMatchPresenter
  def initialize
    @action_presenter = DebugActionPresenter.new
  end

  def present(match)
    home_team = match.home_roster.team
    away_team = match.away_roster.team

    lines = [
      "***** MATCH *****",
      "HomeTeamId=#{home_team.object_id}",
      "AwayTeamId=#{away_team.object_id}",
      "Actions:",
    ]

    match.actions_with_state.each_with_index do |actions_with_state, index|
      action = actions_with_state[:action]
      state = actions_with_state[:state]

      lines << "##{index + 1}"
      lines << "SETUP"
      lines << "#{state.type}"
      lines << "#{state.team}"
      lines << "#{state.attempt}" if (state.type != :kickoff)
      lines << "Yards #{state.ball_yards.from_left}"
      lines << "#{state.progress.class.name}"
      lines << "DESCRIPTION"

      lines += @action_presenter.lines(action)
    end

    lines.join("\n")
  end
end
