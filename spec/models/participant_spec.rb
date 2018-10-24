require 'rails_helper'

RSpec.describe Participant, type: :model do
  let(:params) { { course_id: 1, user_id: 1 } }

  before do
    create(:course, id: 1)
    create(:user, id: 1)
  end

  it "is valid with valid params" do
    user = Participant.create(params)
    expect(user).to be_valid
    expect(user.course_id).to eq 1
    expect(user.user_id).to eq 1
  end

  it { should belong_to(:course) }
  it { should belong_to(:user) }
end
