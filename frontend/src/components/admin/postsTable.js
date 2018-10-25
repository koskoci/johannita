import { h, Component } from 'preact';
import { getPosts, deletePost } from '../../helpers/api';
import { ContentContainer }  from '../../styles/base';
import { StyledTable, TableHead } from '../../styles/admin';

const dateConfig = { year: 'numeric', month: 'numeric', day: 'numeric' };

export default class PostsTable extends Component {
  constructor() {
    super();

    this.state = {
      posts: []
    };
  }

  componentDidMount() {
    getPosts().then(posts => this.setState({ posts }));
  }

  deletePost(id) {
    if (window.confirm('Biztos törölni szeretnéd ezt a hírt?')) {
      deletePost(id).then((res) => {
        if (res.status === 204) getPosts().then(posts => this.setState({ posts }));
      });
    }
  }

  render({ }, { posts }) {
    return (
      <div>
        <TableHead>Hírek <a href="/admin/posts/new">Új hír</a></TableHead>
        <StyledTable>
          <thead>
            <tr><td>ID</td><td>Létrehozva</td><td>Cím</td><td>Opciók</td></tr>
          </thead>
          <tbody>
            {posts.map(post =>
              <tr>
                <td>{post.id}</td>
                <td>{new Date(post.attributes.created_at).toLocaleDateString('hu-HU', dateConfig)}</td>
                <td style={{ minWidth: '300px' }}>{post.attributes.title}</td>
                <td>
                  <a href={`/admin/posts/${post.id}/edit`}>Szerkeszt</a>
                  <a href="" onClick={(evt) => { evt.preventDefault(); this.deletePost(post.id); }}>Töröl</a>
                </td>
              </tr>
            )}
          </tbody>
        </StyledTable>
      </div>
    );
  }
};
