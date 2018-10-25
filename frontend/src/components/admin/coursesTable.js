import { h, Component } from 'preact';
import { getCourses } from '../../helpers/api';
import { ContentContainer }  from '../../styles/base';
import { StyledTable } from '../../styles/admin';

const dateConfig = { year: 'numeric', month: 'numeric', day: 'numeric' };

export default class CoursesTable extends Component {
  constructor() {
    super();

    this.state = {
      courses: []
    };
  }

  componentDidMount() {
    getCourses().then(courses => this.setState({ courses }));
  }

  render({ }, { courses }) {
    return (
      <div>
        <h3>Tanfolyamok</h3>
        <StyledTable>
          <thead>
            <tr><td>ID</td><td>Opciók</td></tr>
          </thead>
          <tbody>
            {courses.map(ce =>
              <tr>
                <td>{ce.id}</td>
                <td></td>
              </tr>
            )}
          </tbody>
        </StyledTable>
      </div>
    );
  }
};
