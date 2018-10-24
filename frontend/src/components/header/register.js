import { h, Component } from 'preact';
import { Overlay, OverlayContent, StyledInput, StyledButton } from '../../styles/base';
import { register } from '../../api';

export default class Register extends Component {
  constructor() {
    super();

    this.state = {
      email: '',
      password: '',
      first_name: '',
      last_name: ''
    }
  }

  register() {
    if (!this.state.email || !this.state.password || !this.state.first_name || !this.state.last_name) return;

    register(this.state).then((success) => {
      console.log(success);
    });
  }

  render({ }, { email, password, first_name, last_name }) {
    return (
      <Overlay>
        <OverlayContent>
          <h3>Regisztráció</h3>
          <StyledInput
            placeholder="Email"
            type="text"
            value={email}
            onChange={(e) => { this.setState({ email: e.target.value }); }}
          />
          <StyledInput
            placeholder="Jelszó"
            type="password"
            value={password}
            onChange={(e) => { this.setState({ password: e.target.value }); }}
          />
          <StyledInput
            placeholder="Keresztnév"
            type="text"
            value={first_name}
            onChange={(e) => { this.setState({ first_name: e.target.value }); }}
          />
          <StyledInput
            placeholder="Vezetéknév"
            type="text"
            value={last_name}
            onChange={(e) => { this.setState({ last_name: e.target.value }); }}
          />
          <StyledButton
            onClick={() => { this.register(); }}
          >Regisztráció</StyledButton>
        </OverlayContent>
      </Overlay>
    );
  }
}
