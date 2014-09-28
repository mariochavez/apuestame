require "test_helper"

describe PaymentsController do
  it "should get index" do
    get :index
    assert_response :success
  end

end
