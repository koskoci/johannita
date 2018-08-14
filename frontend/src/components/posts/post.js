import { h } from 'preact';
import { PostContainer, PostThumb, PostData, PostTitle, PostDate, PostContent } from '../../styles/posts';

const dateConfig = { year: 'numeric', month: 'long', day: 'numeric' };

const Post = ({ data }) => (
  <PostContainer>
    {/*<img src={`http://206.189.55.142/${data.attributes.image_url}`} />*/}
    <PostThumb src="/assets/dummy.jpg" />
    <PostData>
      <PostTitle href={`/posts/${data.id}`}>{data.attributes.title}</PostTitle>
      <PostDate>{new Date(data.attributes.updated_at).toLocaleDateString('hu-HU', dateConfig)}</PostDate>
      <PostContent>{data.attributes.content}</PostContent>
    </PostData>
  </PostContainer>
);

export default Post;
