require 'rails_helper'

RSpec.describe CoursesController, type: :request do
  let(:current_user) { create(:user) }

  before { current_user }

  describe 'GET /courses' do
    subject { get '/api/courses', headers: get_headers(current_user) }

    let(:course) { create(:course) }
    let(:another_course) { create(:course) }
    let(:service_object) { instance_double(Courses::CanApply, call: true) }

    before do
      course
      another_course
    end

    it "uses the correct service for can_apply", :aggregate_failures do
      expect(Courses::CanApply).to receive(:new).with(current_user, course).and_return(service_object)
      expect(Courses::CanApply).to receive(:new).with(current_user, another_course).and_return(service_object)

      subject

      expect(json_response['data']).to all have_attribute(:can_apply).with_value(true)
    end

    it "sends a list of courses", :aggregate_failures do
      subject

      expect(response.status).to eq 200
      expect(json_response['data'].count).to eq(2)
      expect(json_response['data']).to all have_type("courses")
      expect(json_response['data']).to all have_attributes(:title, :category, :created_at, :updated_at, :status, :apply_by, :can_apply)
      expect(json_response['data']).to all have_relationship(:participants)
    end
  end

  describe 'GET /courses/:id' do
    let(:headers) { get_headers(current_user) }

    context "when the course exists" do
      subject { get '/api/courses/1', headers: headers }

      let(:course) { create(:course, id: 1) }
      let(:service_object) { instance_double(Courses::CanApply, call: true) }

      before do
        course
      end

      it "uses the correct service for can_apply", :aggregate_failures do
        expect(Courses::CanApply).to receive(:new).with(current_user, course).and_return(service_object)

        subject

        expect(json_response['data']).to have_attribute(:can_apply).with_value(true)
      end

      context "when there are no participants" do
        it "sends a single course", :aggregate_failures do
          subject

          expect(response.status).to eq 200
          expect(json_response['data']).to have_type("courses")
          expect(json_response['data']).to have_attributes(:title, :category, :created_at, :updated_at, :status, :apply_by, :can_apply)
          expect(json_response['data']).to have_relationship(:participants)
        end
      end

      context "when there are participants" do
        let(:other_user) { create(:user) }

        before do
          Participant.create(course: course, user: other_user)
          Participant.create(course: course, user: current_user)
        end

        it "sends a single course with all included participants", :aggregate_failures do
          subject

          expect(response.status).to eq 200
          expect(json_response['data']).to have_type("courses")
          expect(json_response['data']).to have_attributes(:title, :category, :created_at, :updated_at, :status, :apply_by, :can_apply)
          expect(json_response['data']).to have_relationship(:participants)
          expect(json_response['included'].size).to eq 2
          expect(json_response['included'])
            .to include(have_type('participants').and have_attributes(:name, :email, :attended, :passed))
        end
      end
    end

    context "when the course does not exist" do
      it "returns 404", :aggregate_failures do
        get '/api/courses/1337', headers: headers

        expect(response.status).to eq 404
        expect(json_response['error']).to eq "This course does not exist"
      end
    end
  end

  describe 'POST /courses' do
    subject { post '/api/courses', params: body.to_json, headers: headers }

    let(:body) do
      {
        "data": {
          "type": "courses",
          "attributes": {
            "title": "First course title",
            "category": "kismama",
            "apply_by": "2018/01/01"
          }
        }
      }
    end
    let(:headers) { post_headers(current_user) }
    let(:course_category) { create(:course_category) }

    before { course_category }

    context "when current user is not an admin" do
      it_behaves_like "returns 403 unauthorized with error message"
    end

    context "when current user is an admin" do
      let(:current_user) { create(:user, admin: true) }

      it "returns 204", :aggregate_failures do
        subject

        expect(response.status).to eq 204
      end

      it "creates a Course in the database" do
        expect { subject }
          .to change(Course, :count).by(+1)
      end

      context "when the course category does not exist" do
        let(:body) do
          {
            "data": {
              "type": "courses",
              "attributes": {
                "title": "First course title",
                "category": "Zsakpakolo-tanfolyam",
                "apply_by": "2018/01/01"
              }
            }
          }
        end

        it "returns 400 with an error message" do
          subject

          expect(response.status).to eq 400
          expect(json_response['error']).to eq "This course category does not exist"
        end
      end
    end
  end

  describe 'PATCH /courses/:id' do
    subject { patch '/api/courses/1', params: body.to_json, headers: headers }

    let(:body) do
      {
        "data": {
          "type": "courses",
          "attributes": {
            "title": "Updated course title",
            "category": "Mentoapolo-tanfolyam",
          }
        }
      }
    end
    let(:current_user) { create(:user, admin: true) }
    let(:headers) { post_headers(current_user) }
    let(:course) { create(:course, id: 1, course_category: course_category) }
    let(:course_category) { create(:course_category) }
    let(:another_course_category) { create(:course_category, category: "Mentoapolo-tanfolyam") }
    let(:service_object) { instance_double(CourseCategories::UpdateLastDate, call: OpenStruct.new(deliver_now: true)) }

    before do
      current_user
      course
      another_course_category
    end

    it "returns 200" do
      subject

      expect(response.status).to eq 200
    end

    it "does not create a new Course in the database" do
      expect { subject }.not_to change(Course, :count)
    end

    it "changes the Course in the database" do
      expect { subject }
        .to change { Course.find(1).course_category.category }
        .from("kismama").to("Mentoapolo-tanfolyam")
      expect { subject }
        .not_to change { Course.find(1).apply_by }
    end

    it "returns the updated Course" do
      subject

      expect(json_response['data']).to have_attributes(:title, :category, :created_at, :updated_at, :status, :apply_by, :can_apply)
      expect(json_response['data']).to have_attribute(:category).with_value("Mentoapolo-tanfolyam")
      expect(json_response['data']).to have_attribute(:can_apply).with_value(true)
      expect(json_response['data']).to have_type("courses")
      expect(json_response['data']).to have_id("1")
    end

    context "when current user is not an admin" do
      let(:current_user) { create(:user) }

      it_behaves_like "returns 403 unauthorized with error message"
    end

    context "when the course does not exist" do
      it "returns 404", :aggregate_failures do
        patch '/api/courses/1337', params: body.to_json, headers: headers

        expect(response.status).to eq 404
        expect(json_response['error']).to eq "This course does not exist"
      end
    end

    context "when the course category does not exist" do
      let(:body) do
        {
          "data": {
            "type": "courses",
            "attributes": {
              "title": "Updated course title",
              "category": "Zsakpakolo-tanfolyam",
            }
          }
        }
      end

      it "returns 400 with an error message" do
        subject

        expect(response.status).to eq 400
        expect(json_response['error']).to eq "This course category does not exist"
      end
    end
  end

  describe 'POST /courses/:id/apply' do
    subject { post '/api/courses/1/apply', headers: headers }

    let(:headers) { post_headers(current_user) }
    let(:course) { create(:course, id: 1) }

    before do
      current_user
      course
    end

    it "returns 200 plus the course with participants" do
      subject

      expect(response.status).to eq 200
      expect(json_response['data']).to have_type("courses")
      expect(json_response['data']).to have_attributes(:title, :category, :created_at, :updated_at, :status, :apply_by, :can_apply)
      expect(json_response['data']).to have_relationship(:participants)
      expect(json_response['included'].size).to eq 1
      expect(json_response['included'])
        .to include(have_type('participants').and have_attributes(:name, :email, :attended, :passed))
    end

    it "creates a participant in the database" do
      expect { subject }
        .to change(Participant, :count).by(+1)
    end

    context "when the same participant already exists" do
      before { Participant.create(course: course, user: current_user) }

      it "returns 200 plus the course with participants" do
        subject

        expect(response.status).to eq 200
        expect(json_response['data']).to have_type("courses")
        expect(json_response['data']).to have_attributes(:title, :category, :created_at, :updated_at, :status, :apply_by, :can_apply)
        expect(json_response['data']).to have_relationship(:participants)
        expect(json_response['included'].size).to eq 1
        expect(json_response['included'])
          .to include(have_type('participants').and have_attributes(:name, :email, :attended, :passed))
      end
    end

    context "when the course does not exist" do
      it "returns 404", :aggregate_failures do
        post '/api/courses/1337/apply', headers: headers

        expect(response.status).to eq 404
        expect(json_response['error']).to eq "This course does not exist"
      end
    end
  end

  describe 'PATCH /courses/:id/confirm' do
    subject { patch '/api/courses/1/confirm', headers: headers }

    let(:current_user) { create(:user, admin: true) }
    let(:headers) { post_headers(current_user) }
    let(:course) { create(:course, id: 1) }

    before do
      Participant.create(course: course, user: current_user)
    end

    it "returns 200 plus the course without participants" do
      subject

      expect(response.status).to eq 200
      expect(json_response['data']).to have_type("courses")
      expect(json_response['data']).to have_attribute(:status).with_value("confirmed")
      expect(json_response['data']).to have_attributes(:title, :category, :created_at, :updated_at)
      expect(json_response['data']).to have_relationship(:participants)
      expect(json_response['included']).to be nil
    end

    it "changes the status of the course in the database" do
      expect { subject }
        .to change { Course.find(1).status }
          .from("posted").to("confirmed")
    end

    it "uses the correct worker" do
      expect(CourseConfirmedWorker)
        .to receive(:perform_async).with(course.id)

      subject
    end

    context "when the status is already confirmed" do
      let(:course) { create(:course, id: 1, status: "confirmed") }

      it "returns 200 plus the course without participants" do
        subject

        expect(response.status).to eq 200
        expect(json_response['data']).to have_type("courses")
        expect(json_response['data']).to have_attribute(:status).with_value("confirmed")
        expect(json_response['data']).to have_attributes(:title, :category, :created_at, :updated_at)
        expect(json_response['data']).to have_relationship(:participants)
        expect(json_response['included']).to be nil
      end

      it "does not change the status of the course in the database" do
        expect { subject }
          .not_to change { Course.find(1).status }
      end
    end

    context "when the course does not exist" do
      it "returns 404", :aggregate_failures do
        post '/api/courses/1337/apply', headers: headers

        expect(response.status).to eq 404
        expect(json_response['error']).to eq "This course does not exist"
      end
    end

    context "when current user is not an admin" do
      let(:current_user) { create(:user) }

      it_behaves_like "returns 403 unauthorized with error message"
    end
  end

  describe 'PATCH /courses/:id/cancel' do
    subject { patch '/api/courses/1/cancel', headers: headers }

    let(:current_user) { create(:user, admin: true) }
    let(:headers) { post_headers(current_user) }
    let(:course) { create(:course, id: 1) }

    before do
      Participant.create(course: course, user: current_user)
    end

    it "returns 200 plus the course without participants" do
      subject

      expect(response.status).to eq 200
      expect(json_response['data']).to have_type("courses")
      expect(json_response['data']).to have_attribute(:status).with_value("cancelled")
      expect(json_response['data']).to have_attributes(:title, :category, :created_at, :updated_at)
      expect(json_response['data']).to have_relationship(:participants)
      expect(json_response['included']).to be nil
    end

    it "changes the status of the course in the database" do
      expect { subject }
        .to change { Course.find(1).status }
          .from("posted").to("cancelled")
    end

    it "uses the correct worker" do
      expect(CourseCancelledWorker)
        .to receive(:perform_async).with(course.id)

      subject
    end

    context "when the status is already cancelled" do
      let(:course) { create(:course, id: 1, status: "cancelled") }

      it "returns 200 plus the course without participants" do
        subject

        expect(response.status).to eq 200
        expect(json_response['data']).to have_type("courses")
        expect(json_response['data']).to have_attribute(:status).with_value("cancelled")
        expect(json_response['data']).to have_attributes(:title, :category, :created_at, :updated_at)
        expect(json_response['data']).to have_relationship(:participants)
        expect(json_response['included']).to be nil
      end

      it "does not change the status of the course in the database" do
        expect { subject }
          .not_to change { Course.find(1).status }
      end
    end

    context "when the course does not exist" do
      it "returns 404", :aggregate_failures do
        post '/api/courses/1337/apply', headers: headers

        expect(response.status).to eq 404
        expect(json_response['error']).to eq "This course does not exist"
      end
    end

    context "when current user is not an admin" do
      let(:current_user) { create(:user) }

      it_behaves_like "returns 403 unauthorized with error message"
    end
  end
end
