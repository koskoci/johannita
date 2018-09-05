require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:minimum_params) { { password: "abc", email: "foo@bar.com", first_name: "Foo", last_name: "Bar" } }

  it "is valid with minimum params" do
    expect(User.new(minimum_params)).to be_valid
  end

  %i[password email first_name last_name].each do |attribute|
    it "is not valid without #{attribute}" do
      expect(User.new(minimum_params.reject { |k, _| k == attribute })).not_to be_valid
    end
  end

  context "validates email" do
    it "is not valid if email not unique" do
      user_1 = User.create(minimum_params)
      expect(User.new(minimum_params.merge(email: "foo@bar.com"))).not_to be_valid
    end

    it "is not valid without an email" do
      expect(User.new(password: "abc")).not_to be_valid
    end
  end

  %i[driving_licence_since pav_until].each do |field|
    context "valid with different date formats for #{field}" do
      it "is valid with June 7, 2017" do
        user = User.new(minimum_params.merge(field => "June 7, 2017"))
        expect(user).to be_valid
        expect(user.send(field)).to eq Date.parse("2017-06-07")
      end

      it "is valid with 07-06-2017" do
        user = User.new(minimum_params.merge(field => "07-06-2017"))
        expect(user).to be_valid
        expect(user.send(field)).to eq Date.parse("2017-06-07")
      end
    end

    it "is not valid with an invalid date" do
      expect(User.new(minimum_params.merge(field => "2017-17-07"))).not_to be_valid
    end
  end

  context "when it has a cv attached" do
    let(:user) { User.create(minimum_params) }
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
    let(:user) { User.create(minimum_params) }
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
end
