require "./spec/factories"

RSpec.describe DebugReceptionPhasePresenter do
  let(:presenter) { DebugReceptionPhasePresenter.new }
  subject(:description) { presenter.present(reception_phase) }

  describe "with default reception" do
    let(:reception_phase) { Factory.new.default_reception_phase }

    it "generates text description" do
      expect(description).to eq("[Reception] Player=Robert; YardsDiff=0; NextPhase=return; TimeInSeconds=0;")
    end
  end

  describe "with another reception" do
    let(:reception_phase) do
      ReceptionPhase.new(
        player: Player.new(position: "K", name: "Starczewski"),
        yards_diff: Yards.new(1),
        next_phase: :run,
        time_in_seconds: 2,
      )
    end

    it "generates text description" do
      expect(description).to eq("[Reception] Player=Starczewski; YardsDiff=1; NextPhase=run; TimeInSeconds=2;")
    end
  end
end
