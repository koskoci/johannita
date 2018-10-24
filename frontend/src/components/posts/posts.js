import { h, Component } from 'preact';
import { getPosts } from '../../api';
import { ContentContainer }  from '../../styles/base';
import PostBlock from './_post';

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
        {posts.map(post => <PostBlock data={post} />)}
      </ContentContainer>
    );
  }
};
