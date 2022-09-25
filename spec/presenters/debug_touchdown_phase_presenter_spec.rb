require "./spec/factories"

RSpec.describe DebugTouchdownPhasePresenter do
  let(:presenter) { DebugTouchdownPhasePresenter.new }
  subject(:description) { presenter.present(touchdown_phase) }

  describe "with default td" do
    let(:touchdown_phase) { Factory.new.default_phase(:touchdown) }

    it "generates text description" do
      expect(description).to eq("[TD] Player=Robert; YardsDiff=0; NextPhase=; TimeInSeconds=0;")
    end
  end

  describe "with another td" do
    let(:touchdown_phase) do
      TouchdownPhase.new(
        player: Player.new(position: "QB", name: "Starczewski"),
        yards_diff: Yards.new(1),
        next_phase: :touchdown,
        time_in_seconds: 2,
      )
    end

    it "generates text description" do
      expect(description).to eq("[TD] Player=Starczewski; YardsDiff=1; NextPhase=touchdown; TimeInSeconds=2;")
    end
  end
end
