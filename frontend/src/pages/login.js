import { h, Component } from 'preact';
import { login } from '../helpers/auth';
import { ContentContainer, StyledInput, StyledButton }  from '../styles/base';
import { Line }  from '../styles/profile';

export default class Login extends Component {
  constructor() {
    super();

    this.state = {
      userName: '',
      password: '',
      showError: false
    }
  }

  signIn() {
    const { userName, password } = this.state;

    if (!userName || !password) return;

    this.setState({ showError: false });
    login(userName, password).then((success) => {
      this.setState({ showError: !success });
    });
  }

  render({ }, { userName, password, showError }) {

    return (
      <ContentContainer centered>
        <h3>Bejelentkezés</h3>
        <Line>
          <label>Felhasználónév</label>
          <StyledInput
            placeholder="Felhasználónév"
            type="text"
            value={userName}
            onChange={(e) => { this.setState({ userName: e.target.value }); }}
            simple
          />
        </Line>
        <Line>
          <label>Jelszó</label>
          <StyledInput
            placeholder="Jelszó"
            type="password"
            value={password}
            onChange={(e) => { this.setState({ password: e.target.value }); }}
            simple
          />
        </Line>
        <br />
        <StyledButton
          onClick={() => { this.signIn(); }}
        >Bejelentkezés</StyledButton>

        {showError ? <p>A felhasználónév vagy jelszó nem érvényes!</p> : null}
      </ContentContainer>
    );
  }
};
