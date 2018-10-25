import { h, Component } from 'preact';
import { getProfile, updateProfile } from '../helpers/api';
import { ContentContainer, StyledInput, StyledButton }  from '../styles/base';
import { Line }  from '../styles/profile';

export default class Profile extends Component {
  constructor() {
    super();

    this.state = {
      profile: {
        driving_licence_since: null,
        email: '',
        first_name: '',
        last_name: '',
        pav_until: null
      }
    };
  }

  componentDidMount() {
    getProfile().then((data) => {
      this.setState({ profile: data.attributes });
    });
  }

  updateProfile() {
    updateProfile(this.state.profile).then((data) => {
      this.setState({ profile: data.attributes });
    });
  }

  onChange(field, value) {
    const newProfile = JSON.parse(JSON.stringify(this.state.profile));

    newProfile[field] = value;

    this.setState({ profile: newProfile});
  }

  render({ }, { profile }) {
    return (
      <ContentContainer centered>
        <h3>Profil adatok</h3>
        <Line>
          <label>Email</label>
          <span>{profile.email}</span>
        </Line>
        <Line>
          <label>Vezetéknév</label>
          <StyledInput
            value={profile.last_name}
            onChange={(evt) => { this.onChange('last_name', evt.target.value); }}
            simple
          />
        </Line>
        <Line>
          <label>Keresztnév</label>
          <StyledInput
            value={profile.first_name}
            onChange={(evt) => { this.onChange('first_name', evt.target.value); }}
            simple
          />
        </Line>
        <Line>
          <label>Jogosítvány kelte</label>
          <StyledInput
            type="date"
            value={profile.driving_licence_since}
            onChange={(evt) => { this.onChange('driving_licence_since', evt.target.value); }}
            simple
          />
        <Line>
        </Line>
          <label>PAV érvényesség</label>
          <StyledInput
            type="date"
            value={profile.pav_until}
            onChange={(evt) => { this.onChange('pav_until', evt.target.value); }}
            simple
          />
        </Line>
        <br />
        <StyledButton onClick={() => { this.updateProfile(); }}>Változtatások mentése</StyledButton>

        {/*
        <div>
          Cover letter
        </div>

        <div>
          Curriculum vitae
        </div>
        */}
      </ContentContainer>
    );
  }
};
