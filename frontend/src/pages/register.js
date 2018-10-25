import { h, Component } from 'preact';
import { register } from '../helpers/auth';
import { ContentContainer, StyledInput, StyledButton }  from '../styles/base';
import { Line }  from '../styles/profile';

export default class Register extends Component {
  constructor() {
    super();

    this.state = {
      email: '',
      password: '',
      first_name: '',
      last_name: '',
      showError: false
    }
  }

  register() {
    if (!this.state.email || !this.state.password || !this.state.first_name || !this.state.last_name) return;

    this.setState({ showError: false });
    register({
      email: this.state.email,
      password: this.state.password,
      first_name: this.state.first_name,
      last_name: this.state.last_name
    }).then((success) => {
      this.setState({ showError: !success });
    });
  }

  render({ }, { email, password, first_name, last_name, showError }) {

    return (
      <ContentContainer centered>
        <h3>Regisztráció</h3>
        <Line>
          <label>Email</label>
          <StyledInput
            placeholder="Email"
            type="text"
            value={email}
            onChange={(e) => { this.setState({ email: e.target.value }); }}
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
        <Line>
          <label>Vezetéknév</label>
          <StyledInput
            placeholder="Vezetéknév"
            type="text"
            value={last_name}
            onChange={(e) => { this.setState({ last_name: e.target.value }); }}
            simple
          />
        </Line>
        <Line>
          <label>Keresztnév</label>
          <StyledInput
            placeholder="Keresztnév"
            type="text"
            value={first_name}
            onChange={(e) => { this.setState({ first_name: e.target.value }); }}
            simple
          />
        </Line>
        <br />
        <StyledButton
          onClick={() => { this.register(); }}
        >Regisztráció</StyledButton>

         {showError ? <p>Az adott email címmel már létezik felhasználói fiók!</p> : null}
      </ContentContainer>
    );
  }
};
