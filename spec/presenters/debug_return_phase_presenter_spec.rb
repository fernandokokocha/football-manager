require "./spec/factories"

RSpec.describe DebugReturnPhasePresenter do
  let(:presenter) { DebugReturnPhasePresenter.new }
  subject(:description) { presenter.present(return_phase) }

  describe "with default return" do
    let(:return_phase) { Factory.new.default_phase(:return) }

    it "generates text description" do
      expect(description).to eq("[Return] Returner=Robert; YardsDiff=30; NextPhase=tackle; TimeInSeconds=15;")
    end
  end

  describe "with another return" do
    let(:return_phase) do
      ReturnPhase.new(
        returner: Player.new(position: "K", name: "Starczewski"),
        yards_diff: Yards.new(1),
        next_phase: :touchdown,
        time_in_seconds: 2,
      )
    end

    it "generates text description" do
      expect(description).to eq("[Return] Returner=Starczewski; YardsDiff=1; NextPhase=touchdown; TimeInSeconds=2;")
    end
  end
end
