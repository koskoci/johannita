RSpec.shared_examples "returns 403 unauthorized with error message" do
  it "returns 403" do
    subject

    expect(response.status).to eq 403
    expect(json_response['error']).to eq "Not Permitted"
  end
end

RSpec.shared_examples "returns 401 unauthenticated with error message" do
  it "returns 401" do
    subject

    expect(response.status).to eq 401
    expect(json_response['error']).to eq({"token"=>["Authentication token missing!"]})
  end
end
