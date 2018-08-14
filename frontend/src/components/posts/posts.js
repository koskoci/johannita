import { h, Component } from 'preact';
import { getPosts } from '../../api';
import { ContentContainer }  from '../../styles/base';
import Post from './post';

export default class Posts extends Component {
  constructor() {
    super();

    this.state = {
      posts: []
    };
  }

  componentDidMount() {
    getPosts().then((posts) => {
      this.setState({ posts });
    });
  }

  render({ }, { posts }) {
    return (
      <ContentContainer>
        {posts.map(post => <Post data={post} />)}
      </ContentContainer>
    );
  }
};
