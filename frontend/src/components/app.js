import { h, Component } from 'preact';
import { Router } from 'preact-router';

import { AppContainer } from '../styles/base';

import Header from './header';
import Footer from './footer';
import Posts from './posts';

export default class App extends Component {
  constructor() {
    super();

    this.state = {}
  }

  handleRoute = e => {
    this.currentUrl = e.url;
  };

  componentDidMount() {

  }

  render({ }, { }) {
    return (
      <AppContainer>
        <Header />
        <Router onChange={this.handleRoute}>
          <Posts path="/" />
        </Router>
        <Footer />
      </AppContainer>
    );
  }
}
