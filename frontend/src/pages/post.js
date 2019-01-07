import { h, Component } from 'preact';
import { getPost } from '../helpers/api';
import { ContentContainer }  from '../styles/base';
import PostBlock from '../components/postBlock';

export default class Posts extends Component {
  constructor() {
    super();

    this.state = {
      post: null
    };
  }

  componentDidMount() {
    if (this.props.id) {
      getPost(this.props.id).then((post) => {
        this.setState({ post });
      });
    }
  }

  render({ editable, newPost }, { post }) {
    return (
      <ContentContainer centered>
        {post || newPost ? <PostBlock data={post} editable={editable} newPost={newPost} /> : null}
      </ContentContainer>
    );
  }
};
