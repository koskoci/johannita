import { h, Component } from 'preact';
import { getProfile } from '../../api';
import { ContentContainer, StyledInput, StyledButton }  from '../../styles/base';
import { Line }  from '../../styles/profile';

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
      this.setState({ profile: data.attributes});
    });
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
          <StyledInput value={profile.last_name} simple />
        </Line>
        <Line>
          <label>Keresztnév</label>
          <StyledInput value={profile.first_name} simple />
        </Line>
        <Line>
          <label>Jogosítvány kelte</label>
          <StyledInput type="date" value={profile.driving_licence_since} simple />
        <Line>
        </Line>
          <label>PAV érvényesség</label>
          <StyledInput type="date" value={profile.pav_until} simple />
        </Line>
        <StyledButton onClick={() => {  }}>Változtatások mentése</StyledButton>

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
