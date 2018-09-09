require 'rails_helper'

RSpec.describe Participant, :type => :model do
  let(:params) { { course_event_id: 1, user_id: 1 } }

  before do
    create(:course_event, id: 1)
    create(:user, id: 1)
  end

  it "is valid with valid params" do
    user = Participant.create(params)
    expect(user).to be_valid
    expect(user.course_event_id).to eq 1
    expect(user.user_id).to eq 1
  end

  it "belongs to an course_event" do
    assc = described_class.reflect_on_association(:course_event)
    expect(assc.macro).to eq :belongs_to
  end

  it "belongs to a user" do
    assc = described_class.reflect_on_association(:user)
    expect(assc.macro).to eq :belongs_to
  end
end
