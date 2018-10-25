import { h, Component } from 'preact';
import { getUsers } from '../../helpers/api';
import { ContentContainer }  from '../../styles/base';
import { StyledTable } from '../../styles/admin';

export default class UsersTable extends Component {
  constructor() {
    super();

    this.state = {
      users: []
    };
  }

  componentDidMount() {
    getUsers().then(users => this.setState({ users }));
  }

  render({ }, { users }) {
    return (
      <div>
        <h3>Felhasználók</h3>
        <StyledTable>
          <thead>
            <tr><td>ID</td><td>Email</td><td>Név</td><td>Jogosítvány</td><td>PAV</td><td>Opciók</td></tr>
          </thead>
          <tbody>
            {users.map(user =>
              <tr>
                <td>{user.id}</td>
                <td>{user.attributes.email}</td>
                <td>{user.attributes.last_name} {user.attributes.first_name}</td>
                <td>{user.attributes.driving_licence_since}</td>
                <td>{user.attributes.pav_until}</td>
                <td>
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
