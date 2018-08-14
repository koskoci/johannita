import { h, Component } from 'preact';
import { Overlay, OverlayContent, StyledInput, StyledButton } from '../../styles/base';
import { auth } from '../../api';

export default class Login extends Component {
  constructor() {
    super();

    this.state = {
      userName: '',
      password: ''
    }
  }

  signIn() {
    const { userName, password } = this.state;

    if (!userName || !password) return;

    //auth('kosi@joh.hu', 'abc123');

    auth(userName, password).then((success) => {
      console.log(success);
    });
  }

  render({ }, { userName, password }) {
    return (
      <Overlay>
        <OverlayContent>
          <h3>Bejelentkezés</h3>
          <StyledInput
            placeholder="Felhasználónév"
            type="text"
            value={userName}
            onChange={(e) => { this.setState({ userName: e.target.value }); }}
          />
          <StyledInput
            placeholder="Jelszó"
            type="password"
            value={password}
            onChange={(e) => { this.setState({ password: e.target.value }); }}
          />
          <StyledButton
            onClick={() => { this.signIn(); }}
          >Bejelentkezés</StyledButton>
        </OverlayContent>
      </Overlay>
    );
  }
}
