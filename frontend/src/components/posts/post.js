import { h, Component } from 'preact';
import { getPost } from '../../api';
import { ContentContainer }  from '../../styles/base';
import PostBlock from './_post';

export default class Posts extends Component {
  constructor() {
    super();

    this.state = {
      post: null
    };
  }

  componentDidMount() {
    getPost(this.props.id).then((post) => {
      this.setState({ post });
    });
  }

  render({ editable }, { post }) {
    return (
      <ContentContainer>
        {post ? <PostBlock data={post} editable={editable} /> : null}
      </ContentContainer>
    );
  }
};
