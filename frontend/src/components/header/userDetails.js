import { h, Component } from 'preact';
import Login from './login';
import Register from './register';
import { Overlay, OverlayContent, StyledInput, StyledButton } from '../../styles/base';
import { UserContainer, ProfilBlock } from '../../styles/header';
import { signOut, auth } from '../../api';

export default class UserDetails extends Component {
  constructor() {
    super();

    this.state = {
      showLogin: false,
      showRegister: false
    }
  }

  toggleLogin(showLogin) {
    this.setState({ showLogin });
  }

  toggleRegister(showRegister) {
    this.setState({ showRegister });
  }

  render({ }, { showLogin, showRegister }) {
    return (
      <UserContainer>
        {window.localStorage.getItem('token') ?
          <ProfilBlock>
            {window.localStorage.getItem('userName')}
            <ul>
              <li><a href="/admin">Admin</a></li>
              <li><a href="/profil">Profil</a></li>
              <li><a href="#" onClick={() => { signOut() }}>Kijelentkezés</a></li>
            </ul>
          </ProfilBlock> :
          <div>
            <a href="" onClick={(e) => { e.preventDefault(); this.toggleLogin(true); }}>Bejelentkezés</a>
            <a href="" onClick={(e) => { e.preventDefault(); this.toggleRegister(true); }}>Regisztráció</a>
          </div>
        }
        {showLogin ? <Login /> : null}
        {showRegister ? <Register /> : null}
      </UserContainer>
    );
  }
}
