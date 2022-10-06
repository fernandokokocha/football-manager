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

    match.actions_with_setup.each_with_index do |actions_with_setup, index|
      action = actions_with_setup[:action]
      setup = actions_with_setup[:setup]

      lines << "##{index + 1}"
      lines << "SETUP"
      lines << "#{setup.type}"
      lines << "#{setup.team}"
      lines << "#{setup.attempt}" if (setup.type != :kickoff)
      lines << "Yards #{setup.ball_yards.from_left}"
      lines << "#{setup.first_down_marker.starting_progress.class.name}"
      lines << "DESCRIPTION"

      lines += @action_presenter.lines(action)
    end

    lines.join("\n")
  end
end
