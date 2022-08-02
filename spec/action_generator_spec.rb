# require "football_manager"

# RSpec.describe ActionGenerator do
#   describe "#generate" do
#     let(:team_1) { Team.new }
#     let(:team_2) { Team.new }
#     let(:kicker) { Player.new(position: "K", name: "Przemek") }
#     let(:returner) { Player.new(position: "KR", name: "Bartek") }
#     let(:roster_1) { Roster.new(team: team_1, kicker: kicker, returner: nil) }
#     let(:roster_2) { Roster.new(team: team_2, kicker: nil, returner: returner) }
#     let(:generators_params) { {} }
#     let(:event_generators) { PhaseGenerators.new(generators_params) }
#     let(:action_generator) { ActionGenerator.new }

#     subject(:action) { action_generator.generate(roster_1, roster_2, event_generators) }

#     it "generates action with default data" do
#       expect(kickoff).to eq(Action.new(offence_team: team_1,
#                                        starting_yards: YardsInPitch.new(from_left: 35),
#                                        ending_yards: YardsInPitch.new(from_left: 55),
#                                        phases: [
#                                          KickoffPhase.new(kicker: kicker, yards_from: Yards.new(35), yards_diff: Yards.new(50), next_event: :reception),
#                                          ReceptionPhase.new(player: returner, yards_diff: Yards.new(0), next_event: :return),
#                                          ReturnPhase.new(returner: returner, yards_diff: Yards.new(-30), next_event: :tackle),
#                                          TacklePhase.new(yards_diff: Yards.new(0), next_event: nil),
#                                        ],
#                                        time_in_seconds: 30,
#                                        next_action: :team_2_attempt))
#     end
#   end
# end
