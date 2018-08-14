import { h, Component } from 'preact';
import { Router } from 'preact-router';

import { AppContainer } from '../styles/base';
import { auth } from '../api';

import Header from './header/header';
import Footer from './footer';
import Posts from './posts/posts';
import Admin from './admin/admin';

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
          <Admin path="/admin" />
        </Router>
        <Footer />
      </AppContainer>
    );
  }
}
