import { h, Component } from 'preact';
import { updatePost, createPost, uploadImageToPost } from '../helpers/api';
import { PostContainer, PostThumb, PostData, PostTitle, PostDate, PostContent } from '../styles/posts';
import { StyledInput, StyledTextArea, StyledButton }  from '../styles/base';

const dateConfig = { year: 'numeric', month: 'long', day: 'numeric' };

export default class PostBlock extends Component {
  constructor(props) {
    super();

    this.state = {
      data: props.newPost ? {
        attributes: {
          date: new Date(),
          title: '',
          content: ''
        }
      } : props.data
    };
  }

  onChange(field, value) {
    const newData = JSON.parse(JSON.stringify(this.state.data));

    newData.attributes[field] = value;

    this.setState({ data: newData });
  }

  updatePost() {
    if (this.props.newPost) {
      createPost(this.state.data.attributes).then((res) => {
        if (res.status === 204) {
          window.location.href = `/admin/posts`;
        }
      });
    } else {
      updatePost(this.state.data.id, this.state.data.attributes).then((res) => {
        if (res.status === 200) {
          res.json().then(data => this.setState({ data: data.data }));
        }
      });
    }
  }

  uploadImage(evt) {
    uploadImageToPost(this.state.data.id, evt.target.files[0]).then((res) => {
      console.log(res);
    });
  }

  render({ editable, newPost }, { data }) {
    if (editable || newPost) {
      return (
        <PostContainer>
          <div>
            <label>Cím</label>
            <StyledInput
              type="text"
              value={data.attributes.title}
              onChange={(evt) => { this.onChange('title', evt.target.value); }}
              simple
              block
            />
          </div>
          <br />
          <div>
            <label>Tartalom</label>
            <StyledTextArea
              type="text"
              value={data.attributes.content}
              onChange={(evt) => { this.onChange('content', evt.target.value); }}
            />
          </div>
          <div>
            <label>Utolsó frissítés</label><br />
            {new Date(data.attributes.updated_at).toLocaleString('hu-HU')}
          </div>
          <br />
          <StyledButton onClick={() => { this.updatePost(); }}>Mentés</StyledButton>


          {!newPost ?
            <div>
              <h3>Képek</h3>
              {data.relationships.images.data.map(img => <span>{img}</span>)}
              <input type="file" onChange={(evt) => { this.uploadImage(evt); }} />
            </div>
            : null
          }

        </PostContainer>
      );
    }

    return (
      <PostContainer>
        <PostThumb src={data.attributes.image_url} />
        <PostData>
          <PostTitle href={`/posts/${data.id}`}>{data.attributes.title}</PostTitle>
          <PostDate>{new Date(data.attributes.updated_at).toLocaleDateString('hu-HU', dateConfig)}</PostDate>
          <PostContent>{data.attributes.content}</PostContent>
        </PostData>
      </PostContainer>
    );
  }
}
