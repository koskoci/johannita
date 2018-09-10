require 'rails_helper'

RSpec.describe CourseCategoriesController, :type => :request do
  let(:current_user) { create(:user) }

  before { current_user }

  describe 'GET /course_categories' do
    let(:course_category) { create :course_category }

    before do
      create :course_event, date: "2020-01-01", course_category: course_category
      create :course_event, date: "2019-01-01", course_category: course_category
      create :course_category, category: "otthonapolas"
    end

    it "sends a list of course_categories", :aggregate_failures do
      get '/course_categories', headers: get_headers(current_user)

      expect(response.status).to eq 200
      expect(json_response['data'].count).to eq(2)
      expect(json_response['data']).to all have_attributes(:category, :title, :prerequisite_course_category_id, :last_date, :created_at, :updated_at)
      expect(json_response['data'].first).to have_attribute(:last_date).with_value("2020-01-01")
      expect(json_response['data'].last).to have_attribute(:last_date).with_value(nil)
      expect(json_response['data']).to all have_type("course_categories")
    end
  end

  describe 'GET /course_categories/:id' do
    let(:headers) { get_headers(current_user) }
    let(:course_category) { create :course_category, id: 1 }

    context "when the course_category exists" do
      before do
        create(:course_event, course_category: course_category, date: "2018-01-01")
      end

      it "sends a single course_category", :aggregate_failures do
        get '/course_categories/1', headers: headers

        expect(response.status).to eq 200
        expect(json_response['data']).to have_type("course_categories")
        expect(json_response['data']).to have_attributes(:category, :last_date, :created_at, :updated_at)
        expect(json_response['data']).to have_attribute(:last_date).with_value("2018-01-01")
      end

      it "updates last_date in the database" do
        expect { get '/course_categories/1', headers: headers }
          .to change { CourseCategory.find(1).last_date }
          .from(nil).to(Date.parse("2018-01-01"))
      end
    end

    context "when the course_category does not exist" do
      it "returns 404", :aggregate_failures do
        get '/course_categories/1337', headers: headers

        expect(response.status).to eq 404
        expect(json_response['error']).to eq "This course category does not exist"
      end
    end
  end

  describe 'POST /course_categories' do
    subject { post '/course_categories', params: body.to_json, headers: headers }

    let(:body) do
      {
        "data": {
          "type": "course_categories",
          "attributes": {
            "category": "kismama",
          }
        }
      }
    end
    let(:headers) { post_headers(current_user) }

    context "when current user is not an admin" do
      it_behaves_like "returns 403 unauthorized with error message"
    end

    context "when current user is an admin" do
      let(:current_user) { create(:user, admin: true) }

      it "returns 201" do
        subject

        expect(response.status).to eq 201
      end

      it "creates a CourseCategory in the database" do
        expect { subject }
          .to change(CourseCategory, :count).by(+1)
      end

      it "returns the created CourseCategory" do
        subject

        expect(json_response['data']).to have_attributes(:category, :title, :prerequisite_course_category_id, :last_date, :created_at, :updated_at)
        expect(json_response['data']).to have_type("course_categories")
        expect(json_response['data']['id']).not_to be nil
      end
    end
  end

  describe 'PATCH /course_categories/:id' do
    subject { patch '/course_categories/1', params: body.to_json, headers: headers }

    let(:body) do
      {
        "data": {
          "type": "course_categories",
          "attributes": {
            "category": "Zsakpakolo-tanfolyam",
          }
        }
      }
    end
    let(:current_user) { create(:user, admin: true) }
    let(:course_category) { create(:course_category, id: 1) }
    let(:headers) { post_headers(current_user) }

    before do
      current_user
      course_category
    end

    it "returns 200" do
      subject

      expect(response.status).to eq 200
    end

    it "does not create a new CourseCategory in the database" do
      expect { subject }.not_to change(CourseCategory, :count)
    end

    it "changes the CourseCategory in the database" do
      expect { subject }
        .to change { CourseCategory.find(1).category }
        .from("kismama").to("Zsakpakolo-tanfolyam")
      expect { subject }
        .not_to change { CourseCategory.find(1).last_date }
    end

    it "returns the updated CourseCategory" do
      subject

      expect(json_response['data']).to have_attributes(:category, :title, :prerequisite_course_category_id, :last_date, :created_at, :updated_at)
      expect(json_response['data']).to have_type("course_categories")
      expect(json_response['data']).to have_id("1")
    end

    context "when current user is not an admin" do
      let(:current_user) { create(:user) }

      it_behaves_like "returns 403 unauthorized with error message"
    end

    context "when the course_category does not exist" do
      it "returns 404", :aggregate_failures do
        patch '/course_categories/1337', params: body.to_json, headers: headers

        expect(response.status).to eq 404
        expect(json_response['error']).to eq "This course category does not exist"
      end
    end
  end

  describe 'DELETE /course_categories/:id' do
    subject { delete '/course_categories/1', headers: headers }

    let(:current_user) { create(:user, admin: true) }
    let(:course_category) { create(:course_category, id: 1) }
    let(:headers) { get_headers(current_user) }

    before do
      current_user
      course_category
    end

    it "returns 204" do
      subject

      expect(response.status).to eq 204
    end

    it "deletes the CourseCategory from the database" do
      expect { subject }.to change(CourseCategory, :count).by(-1)
    end

    context "when current user is not an admin" do
      let(:current_user) { create(:user) }

      it_behaves_like "returns 403 unauthorized with error message"
    end

    context "when the course_category does not exist" do
      it "returns 404", :aggregate_failures do
        delete '/course_categories/1337', headers: headers

        expect(response.status).to eq 404
        expect(json_response['error']).to eq "This course category does not exist"
      end
    end
  end
end
