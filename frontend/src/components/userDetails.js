import { h, Component } from 'preact';
import { Overlay, OverlayContent, StyledInput, StyledButton } from '../styles/base';
import { UserContainer, ProfilBlock } from '../styles/header';
import { logout } from '../helpers/auth';

export default class UserDetails extends Component {
  constructor() {
    super();

    this.state = {}
  }

  render({ }, { }) {
    return (
      <UserContainer>
        {window.localStorage.getItem('token') ?
          <ProfilBlock>
            {window.localStorage.getItem('userName')}
            <ul>
              <li><a href="/admin">Admin</a></li>
              <li><a href="/profil">Profil</a></li>
              <li><a href="#" onClick={() => { logout() }}>Kijelentkezés</a></li>
            </ul>
          </ProfilBlock> :
          <div>
            <a href="" href="/bejelentkezes">Bejelentkezés</a>
            <span> | </span>
            <a href="" href="/regisztracio">Regisztráció</a>
          </div>
        }
      </UserContainer>
    );
  }
}
