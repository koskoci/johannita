import { h, Component } from 'preact';
import Login from './login';
import { Overlay, OverlayContent, StyledInput, StyledButton } from '../../styles/base';
import { UserContainer } from '../../styles/header';
import { signOut, auth } from '../../api';

export default class UserDetails extends Component {
  constructor() {
    super();

    this.state = {
      showLogin: false,
    }
  }

  toggleLogin(toggle) {
    this.setState({ showLogin: toggle });
  }

  render({ }, { showLogin }) {
    return (
      <UserContainer>
        {localStorage.getItem('token') ?
          <div>
            {localStorage.getItem('userName')}
            <br />
            <a
              href="#"
              onClick={() => { signOut() }}
            >Kijelentkezés</a>
          </div> :
          <div>
            <a
              href=""
              onClick={(e) => { e.preventDefault(); this.toggleLogin(true); }}
            >Bejelentkezés</a>
          </div>
        }
        {showLogin? <Login /> : null}
      </UserContainer>
    );
  }
}
