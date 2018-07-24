import { h, Component } from 'preact';
// import { loadPosts } from '../helper';
import { ContentContainer }  from '../styles/base';
import Post from './post';

export default class Posts extends Component {
  constructor() {
    super();

    this.state = {
      posts: [
        {
          "id":"1",
          "type":"posts",
          "attributes": {
            "title":"Test Post",
            "content":"testing, testing ...",
            "created_at":"2018-06-03T22:58:06.984Z",
            "updated_at":"2018-06-03T22:58:06.987Z",
            "image_url":"/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--e6ecdfe64f12222fb3debdaf59aba16fd037da39/IMG_0654.JPG"
          }
        },
        {
          "id":"2",
          "type":"posts",
          "attributes": {
            "title":"My new post",
            "content":"Long-winded boring content about me",
            "created_at":"2018-07-22T20:36:43.048Z",
            "updated_at":"2018-07-22T20:36:43.053Z",
            "image_url":"/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCdz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--f8fc23bc8da85c2f298c71e30c833cdccbf3e35c/1ad9951a672d431963ddd6ef45585fd9.jpg"
          }
        }
      ]
    };
  }

  componentDidMount() {
    /*
    loadPosts().then((posts) => {
      this.setState({ posts });
    });
    */
  }

  render({ }, { posts }) {
    return (
      <ContentContainer>
        {posts.map(post => <Post data={post} />)}
      </ContentContainer>
    );
  }
};
