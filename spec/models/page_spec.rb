require 'rails_helper'

RSpec.describe Page, type: :model do
  let(:params) { { slug: "foo_bar", content: "Blah Blah\n Blah" } }

  subject { Page.new(params) }

  describe "Validations" do
    it { should validate_uniqueness_of(:slug) }
    it { should validate_presence_of(:content) }

    it "is valid with valid params" do
      expect(subject).to be_valid
      expect(subject.slug).to eq "foo_bar"
      expect(subject.content).to eq "Blah Blah\n Blah"
    end

    context "when slug is taken" do
      before do
        create(:page, slug: "foo_bar", content: "Something else entirely")
      end

      it "is not valid" do
        expect(subject).not_to be_valid
      end
    end
  end
end
