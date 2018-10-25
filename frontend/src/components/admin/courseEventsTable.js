import { h, Component } from 'preact';
import { getCourseEvents } from '../../helpers/api';
import { ContentContainer }  from '../../styles/base';
import { StyledTable } from '../../styles/admin';

const dateConfig = { year: 'numeric', month: 'numeric', day: 'numeric' };

export default class CourseEventsTable extends Component {
  constructor() {
    super();

    this.state = {
      courseEvents: []
    };
  }

  componentDidMount() {
    getCourseEvents().then(courseEvents => this.setState({ courseEvents }));
  }

  render({ }, { courseEvents }) {
    return (
      <div>
        <h3>Esemény kategóriák</h3>
        <StyledTable>
          <thead>
            <tr><td>ID</td><td>Opciók</td></tr>
          </thead>
          <tbody>
            {courseEvents.map(ce =>
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
