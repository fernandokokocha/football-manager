require "football-manager"

RSpec.describe Generator do
  describe "#generate" do
    it "generates kickoff stub" do
      team_1 = Team.new
      team_2 = Team.new
      generator = Generator.new
      match = generator.generate(team_1, team_2)
      expect(match).to eq(Kickoff.new)
    end
  end
end
