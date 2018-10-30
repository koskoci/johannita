require 'rails_helper'

RSpec.describe Attendance, type: :model do
  describe "Associations" do
    it { should belong_to(:course_event) }
    it { should belong_to(:participant) }
  end
end
