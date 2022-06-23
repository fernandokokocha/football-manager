require "football-manager"

RSpec.describe Generator do
  describe "#generate" do
    it "generates kickoff off with proper data" do
      team_1 = Team.new
      team_2 = Team.new
      generator = Generator.new
      match = generator.generate(team_1, team_2)
      # expect(match).to eq(Kickoff.new(yards_from: 35, yards_travelled: 50, yards_returned: 30))
      expect(match).to eq(KickoffAction.new([
        KickoffEvent.new(yards_from: 35, yards_travelled: 50),
        ReceptionEvent.new,
        ReturnEvent.new(yards_returned: 30),
        TackleEvent.new,
      ]))
    end
  end
end
