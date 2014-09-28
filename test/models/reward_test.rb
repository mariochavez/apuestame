require "test_helper"

describe Reward do
  let(:reward) { Reward.new }

  it "must be valid" do
    reward.must_be :valid?
  end
end
