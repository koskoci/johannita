RSpec.shared_examples "returns 403 unauthorized with error message" do
  it "returns 403" do
    subject

    expect(response.status).to eq 403
    expect(json_response['error']).to eq "Not Permitted"
  end
end
