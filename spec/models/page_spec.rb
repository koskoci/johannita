require 'rails_helper'

RSpec.describe Page, type: :model do
  let(:params) { { short_name: "foo_bar", content: "Blah Blah\n Blah" } }

  subject { Page.new(params) }

  describe "Validations" do
    it { should validate_uniqueness_of(:short_name) }
    it { should validate_presence_of(:content) }

    it "is valid with valid params" do
      expect(subject).to be_valid
      expect(subject.short_name).to eq "foo_bar"
      expect(subject.content).to eq "Blah Blah\n Blah"
    end

    context "when short_name is taken" do
      before do
        create(:page, short_name: "foo_bar", content: "Something else entirely")
      end

      it "is not valid" do
        expect(subject).not_to be_valid
      end
    end

    context "when it has attachments" do
      let(:page) { described_class.create(params) }
      let(:pdf_fixture) do
        fixture_file_upload(Rails.root.join('spec', 'fixtures', 'pdf.pdf'), 'application/pdf')
      end

      before do
        page.attachments.attach(pdf_fixture)
        page.attachments.last.update(description: "My family tree")
        page.attachments.attach(pdf_fixture)
        page.attachments.last.update(description: "My shopping list")
      end

      it "has attachments" do
        attachments = page.attachments
        expect(attachments).to be_an_instance_of(ActiveStorage::Attached::Many)
        expect(attachments.attached?).to be true
        expect(attachments.count).to eq 2
        expect(attachments.first.filename).to eq "pdf.pdf"
        expect(attachments.first.description).to eq "My family tree"
        expect(attachments.last.description).to eq "My shopping list"
      end
    end
  end
end
