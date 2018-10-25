import { h, Component } from 'preact';
import { Router } from 'preact-router';

import { AppContainer } from '../styles/base';

import Header from '../components/header';
import Footer from '../components/footer';

import Profile from './profile';
import Login from './login';
import Register from './register';
import Posts from './posts';
import Post from './post';
import Page from './page';
import Admin from './admin';

export default class App extends Component {
  constructor() {
    super();

    this.state = {
      isAdmin: false
    };
  }

  handleRoute = e => {
    this.setState({ isAdmin: e.url.startsWith('/admin') });
    this.currentUrl = e.url;
  };

  componentDidMount() {}

  render({ }, { isAdmin }) {
    return (
      <AppContainer>
        <Header isAdmin={isAdmin} />
        <Router onChange={this.handleRoute}>
          <Admin path="/admin" />
          <Admin path="/admin/posts" />
          <Post path="/admin/posts/new" newPost />
          <Post path="/admin/posts/:id/edit" editable />
          <Admin path="/admin/users" />
          <Admin path="/admin/course_categories" />
          <Admin path="/admin/course_events" />
          <Admin path="/admin/courses" />

          <Profile path="/profil" />
          <Login path="/bejelentkezes" />
          <Register path="/regisztracio" />

          <Posts path="/" />
          <Post path="/hirek/:id" />
          <Page path="/oldal/:id" />
        </Router>
        <Footer />
      </AppContainer>
    );
  }
}
