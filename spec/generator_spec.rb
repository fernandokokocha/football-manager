require "football_manager"

RSpec.describe Generator do
  describe "#generate" do
    it "generates kickoff off with proper data" do
      team_1 = Team.new
      team_2 = Team.new
      generator = Generator.new
      match = generator.generate(team_1, team_2)
      expect(match).to eq(KickoffAction.new([
        KickoffEvent.new(yards_from: Yards.new(35), yards_travelled: Yards.new(50)),
        ReceptionEvent.new,
        ReturnEvent.new(yards_returned: Yards.new(30)),
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
        KickoffEvent.new(yards_from: Yards.new(35), yards_travelled: Yards.new(50)),
        ReceptionEvent.new,
        ReturnEvent.new(yards_returned: Yards.new(40)),
        TackleEvent.new,
      ]))
    end

    it "generates kickoff off with random data when random generator provided" do
      team_1 = Team.new
      team_2 = Team.new
      generator = Generator.new
      return_event_generator = RandomReturnEventGenerator.new
      match = generator.generate(team_1, team_2, return_event_generator)
      expect(match).to eq(KickoffAction.new([
        KickoffEvent.new(yards_from: Yards.new(35), yards_travelled: Yards.new(50)),
        ReceptionEvent.new,
        ReturnEvent.new(yards_returned: YardsFromRange.new(nil, 30, 50)),
        TackleEvent.new,
      ]))
    end
  end
end
