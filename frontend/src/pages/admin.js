import { h, Component } from 'preact';
import { getPosts, getUsers, getCourses, getCourseEvents, getCourseCategories } from '../helpers/api';
import { ContentContainer }  from '../styles/base';
import { StyledTable } from '../styles/admin';

import PostsTable from '../components/admin/postsTable';
import UsersTable from '../components/admin/usersTable';
import CourseCategoriesTable from '../components/admin/courseCategoriesTable';
import CourseEventsTable from '../components/admin/courseEventsTable';
import CoursesTable from '../components/admin/coursesTable';

const dateConfig = { year: 'numeric', month: 'numeric', day: 'numeric' };

export default class Admin extends Component {
  constructor() {
    super();

    this.state = {};
  }

  componentDidMount() {}

  render({ path }, { }) {
    return (
      <ContentContainer>
        {path === '/admin/posts' ? <PostsTable /> : null}
        {path === '/admin/users' ? <UsersTable /> : null}
        {path === '/admin/course_categories' ? <CourseCategoriesTable /> : null}
        {path === '/admin/course_events' ? <CourseEventsTable /> : null}
        {path === '/admin/courses' ? <CoursesTable /> : null}
      </ContentContainer>
    );
  }
};
