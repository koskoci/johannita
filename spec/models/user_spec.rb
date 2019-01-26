require 'rails_helper'

RSpec.describe User, type: :model do
  let(:minimum_params) { { password: "abc", email: "foo@bar.com", first_name: "Foo", last_name: "Bar" } }

  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:email) }
  it { should have_secure_password }

  it "is valid with minimum params" do
    expect(described_class.new(minimum_params)).to be_valid
  end

  context "validates email" do
    it "is not valid if email not unique" do
      user_1 = described_class.create(minimum_params)
      expect(described_class.new(minimum_params.merge(email: "foo@bar.com"))).not_to be_valid
    end

    it "is not valid without an email" do
      expect(described_class.new(password: "abc")).not_to be_valid
    end
  end

  %i[driving_licence_since pav_until].each do |field|
    context "valid with different date formats for #{field}" do
      it "is valid with June 7, 2017" do
        user = described_class.new(minimum_params.merge(field => "June 7, 2017"))
        expect(user).to be_valid
        expect(user.send(field)).to eq Date.parse("2017-06-07")
      end

      it "is valid with 07-06-2017" do
        user = described_class.new(minimum_params.merge(field => "07-06-2017"))
        expect(user).to be_valid
        expect(user.send(field)).to eq Date.parse("2017-06-07")
      end
    end

    it "is not valid with an invalid date" do
      expect(described_class.new(minimum_params.merge(field => "2017-17-07"))).not_to be_valid
    end
  end

  context "when it has a cv attached" do
    let(:user) { described_class.create(minimum_params) }
    let(:pdf_fixture) do
      fixture_file_upload(Rails.root.join('spec', 'fixtures', 'pdf.pdf'), 'application/pdf')
    end

    before { user.curriculum_vitae.attach(pdf_fixture) }

    it "has an attached CV" do
      cv = user.curriculum_vitae
      expect(cv).to be_an_instance_of(ActiveStorage::Attached::One)
      expect(cv.attached?).to be true
      expect(cv.filename).to eq "pdf.pdf"
    end
  end

  context "when it has a cover_letter attached" do
    let(:user) { described_class.create(minimum_params) }
    let(:pdf_fixture) do
      fixture_file_upload(Rails.root.join('spec', 'fixtures', 'pdf.pdf'), 'application/pdf')
    end

    before { user.cover_letter.attach(pdf_fixture) }

    it "has an attached CV" do
      cover_letter = user.cover_letter
      expect(cover_letter).to be_an_instance_of(ActiveStorage::Attached::One)
      expect(cover_letter.attached?).to be true
      expect(cover_letter.filename).to eq "pdf.pdf"
    end
  end

  context "when it has images attached" do
    let(:user) { described_class.create(minimum_params) }
    let(:image_fixture) do
      fixture_file_upload(Rails.root.join('spec', 'fixtures', 'Geranium sanguineum.jpg'), 'image/jpg')
    end

    before { user.images.attach(image_fixture) }

    it "has an attached image" do
      images = user.images
      expect(images).to be_an_instance_of(ActiveStorage::Attached::Many)
      expect(images.attached?).to be true
      expect(images.count).to eq 1
      expect(images.first.filename).to eq "Geranium sanguineum.jpg"
    end
  end

  describe "#name" do
    let(:user) { described_class.new(first_name: "Bela", last_name: "Kun") }

    it "returns the full name, last name first" do
      expect(user.name).to eq "Kun Bela"
    end
  end
end
