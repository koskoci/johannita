import { h, Component } from 'preact';
import { getCourseCategories } from '../../helpers/api';
import { ContentContainer }  from '../../styles/base';
import { StyledTable } from '../../styles/admin';

const dateConfig = { year: 'numeric', month: 'numeric', day: 'numeric' };

export default class CourseCategoriesTable extends Component {
  constructor() {
    super();

    this.state = {
      courseCategories: []
    };
  }

  componentDidMount() {
    getCourseCategories().then(courseCategories => this.setState({ courseCategories }));
  }

  render({ }, { courseCategories }) {
    return (
      <div>
        <h3>Esemény kategóriák</h3>
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
                <td>
                  <a href="">Szerkeszt</a>
                  <a href="">Töröl</a>
                </td>
              </tr>
            )}
          </tbody>
        </StyledTable>
      </div>
    );
  }
};
