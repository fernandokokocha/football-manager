require "./spec/factories"

RSpec.describe DebugSnapPhasePresenter do
  let(:presenter) { DebugSnapPhasePresenter.new }
  subject(:description) { presenter.present(snap_phase) }

  describe "with default snap" do
    let(:snap_phase) { Factory.new.default_phase(:snap) }

    it "generates text description" do
      expect(description).to eq("[Snap] Snaper=Cezary; YardsDiff=-10; NextPhase=run; TimeInSeconds=0;")
    end
  end

  describe "with another snap" do
    let(:snap_phase) do
      SnapPhase.new(
        snaper: Player.new(position: "QB", name: "Starczewski"),
        yards_diff: Yards.new(1),
        next_phase: :touchdown,
        time_in_seconds: 2,
      )
    end

    it "generates text description" do
      expect(description).to eq("[Snap] Snaper=Starczewski; YardsDiff=1; NextPhase=touchdown; TimeInSeconds=2;")
    end
  end
end
