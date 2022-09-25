require "./spec/factories"

RSpec.describe DebugRunPhasePresenter do
  let(:presenter) { DebugRunPhasePresenter.new }
  subject(:description) { presenter.present(run_phase) }

  describe "with default run" do
    let(:run_phase) { Factory.new.default_phase(:run) }

    it "generates text description" do
      expect(description).to eq("[Run] Runner=Qba; YardsDiff=11; NextPhase=tackle; TimeInSeconds=30;")
    end
  end

  describe "with another run" do
    let(:run_phase) do
      RunPhase.new(
        runner: Player.new(position: "QB", name: "Starczewski"),
        yards_diff: Yards.new(1),
        next_phase: :touchdown,
        time_in_seconds: 2,
      )
    end

    it "generates text description" do
      expect(description).to eq("[Run] Runner=Starczewski; YardsDiff=1; NextPhase=touchdown; TimeInSeconds=2;")
    end
  end
end
