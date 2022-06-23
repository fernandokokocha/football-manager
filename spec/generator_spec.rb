require "football_manager"

RSpec.describe Generator do
  describe "#generate" do
    it "generates kickoff off with proper data" do
      team_1 = Team.new
      team_2 = Team.new
      generator = Generator.new
      match = generator.generate(team_1, team_2)
      expect(match).to eq(KickoffAction.new([
        KickoffEvent.new(yards_from: 35, yards_travelled: 50),
        ReceptionEvent.new,
        ReturnEvent.new(yards_returned: 30),
        TackleEvent.new,
      ]))
    end

    it "generates kickoff off with different data when other generator provided" do
      team_1 = Team.new
      team_2 = Team.new
      generator = Generator.new
      return_event_generator = ConstantReturnEventGenerator.new(yards_returned: 40)
      match = generator.generate(team_1, team_2, return_event_generator)
      expect(match).to eq(KickoffAction.new([
        KickoffEvent.new(yards_from: 35, yards_travelled: 50),
        ReceptionEvent.new,
        ReturnEvent.new(yards_returned: 40),
        TackleEvent.new,
      ]))
    end
  end
end
