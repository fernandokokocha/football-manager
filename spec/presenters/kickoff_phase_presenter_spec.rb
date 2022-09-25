require "./spec/factories"

RSpec.describe KickoffPhasePresenter do
  let(:kickoff_phase_presenter) { KickoffPhasePresenter.new }
  subject(:description) { kickoff_phase_presenter.present(kickff_phase) }

  describe "with default kickoff" do
    let(:kickff_phase) { Factory.new.default_kickoff_phase }

    it "generates text description" do
      expect(description).to eq("[Kickoff] Kicker=Krzysiek; YardsFrom=35; YardsDiff=50; NextPhase=reception; TimeInSeconds=15;")
    end
  end

  describe "with another kickoff" do
    let(:kickff_phase) do
      KickoffPhase.new(
        kicker: Player.new(position: "K", name: "Starczewski"),
        yards_from: Yards.new(40),
        yards_diff: Yards.new(30),
        next_phase: :reception,
        time_in_seconds: 60,
      )
    end

    it "generates text description" do
      expect(description).to eq("[Kickoff] Kicker=Starczewski; YardsFrom=40; YardsDiff=30; NextPhase=reception; TimeInSeconds=60;")
    end
  end
end
