import { h, Component } from 'preact';
import { getPosts, getCourseEvents, getCourseCategories } from '../../api';
import { ContentContainer }  from '../../styles/base';
import { StyledTable } from '../../styles/admin';

const dateConfig = { year: 'numeric', month: 'numeric', day: 'numeric' };

export default class Admin extends Component {
  constructor() {
    super();

    this.state = {
      posts: [],
      courseCategories: [],
      courseEvents: []
    };
  }

  componentDidMount() {
    getPosts().then(posts => this.setState({ posts }));
    getCourseEvents().then(courseEvents => this.setState({ courseEvents}));
    getCourseCategories().then(courseCategories => this.setState({ courseCategories }));
  }

  render({ }, { posts, courseEvents, courseCategories }) {
    return (
      <ContentContainer>
        <StyledTable>
          <thead>
            <tr><td>ID</td><td>Létrehozva</td><td>Cím</td><td>Opciók</td></tr>
          </thead>
          <tbody>
            {posts.map(post =>
              <tr>
                <td>{post.id}</td>
                <td>{new Date(post.attributes.created_at).toLocaleDateString('hu-HU', dateConfig)}</td>
                <td style={{ minWidth: '300px' }}>{post.attributes.title}</td>
                <td>
                  <a href={`/posts/${post.id}/edit`}>Szerkeszt</a>
                  <a href="">Töröl</a>
                </td>
              </tr>
            )}
          </tbody>
        </StyledTable>

        <StyledTable>
          <thead>
            <tr><td>ID</td><td>Dátum</td><td>Státusz</td><td>Cím</td><td>Kategória</td><td>Jelentkezés</td><td>Opciók</td></tr>
          </thead>
          <tbody>
            {courseEvents.map(ce =>
              <tr>
                <td>{ce.id}</td>
                <td>{new Date(ce.attributes.date).toLocaleDateString('hu-HU', dateConfig)}</td>
                <td>{ce.attributes.status}</td>
                <td>{ce.attributes.title}</td>
                <td>{ce.attributes.category}</td>
                <td>{ce.attributes.can_apply.toString()}</td>
                <td></td>
              </tr>
            )}
          </tbody>
        </StyledTable>

        <StyledTable>
          <thead>
            <tr><td>ID</td><td>Kategória</td><td>Cím</td><td>Előfeltétel ID</td><td>Opciók</td></tr>
          </thead>
          <tbody>
            {courseCategories.map(cc =>
              <tr>
                <td>{cc.id}</td>
                <td>{cc.attributes.category}</td>
                <td>{cc.attributes.title}</td>
                <td>{cc.attributes.prerequisite_course_category_id}</td>
                <td></td>
              </tr>
            )}
          </tbody>
        </StyledTable>
      </ContentContainer>
    );
  }
};
