require "test_helper"

describe Donation do
  let(:donation) { Donation.new }

  it "must be valid" do
    donation.must_be :valid?
  end
end
