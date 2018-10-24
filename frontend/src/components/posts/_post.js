import { h } from 'preact';
import { PostContainer, PostThumb, PostData, PostTitle, PostDate, PostContent } from '../../styles/posts';
import { StyledInput, StyledTextArea, StyledButton }  from '../../styles/base';

const dateConfig = { year: 'numeric', month: 'long', day: 'numeric' };

const PostBlock = ({ data, editable }) => (
  editable ?
    <PostContainer>
      <div>
        <label>Cím</label>
        <StyledInput type="text" value={data.attributes.title} simple block />
      </div>
      <div>
        <label>Tartalom</label>
        <StyledTextArea type="text" value={data.attributes.content} />
      </div>
      <StyledButton onClick={() => {  }}>Mentés</StyledButton>
    </PostContainer>
  :
    <PostContainer>
      <PostThumb src={data.attributes.image_url} />
      <PostData>
        <PostTitle href={`/posts/${data.id}`}>{data.attributes.title}</PostTitle>
        <PostDate>{new Date(data.attributes.updated_at).toLocaleDateString('hu-HU', dateConfig)}</PostDate>
        <PostContent>{data.attributes.content}</PostContent>
      </PostData>
    </PostContainer>
);

export default PostBlock;
