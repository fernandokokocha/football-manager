require "./spec/factories"

RSpec.describe DebugTacklePhasePresenter do
  let(:presenter) { DebugTacklePhasePresenter.new }
  subject(:description) { presenter.present(tackle_phase) }

  describe "with default tackle" do
    let(:tackle_phase) { Factory.new.default_phase(:tackle) }

    it "generates text description" do
      expect(description).to eq("[Tackle] YardsDiff=0; NextPhase=; TimeInSeconds=0;")
    end
  end

  describe "with another snap" do
    let(:tackle_phase) do
      TacklePhase.new(
        yards_diff: Yards.new(1),
        next_phase: :touchdown,
        time_in_seconds: 2,
      )
    end

    it "generates text description" do
      expect(description).to eq("[Tackle] YardsDiff=1; NextPhase=touchdown; TimeInSeconds=2;")
    end
  end
end
