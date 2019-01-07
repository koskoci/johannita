import { h, Component } from 'preact';
import { getPages } from '../../helpers/api';
import { ContentContainer }  from '../../styles/base';
import { StyledTable, TableHead } from '../../styles/admin';

const dateConfig = { year: 'numeric', month: 'numeric', day: 'numeric' };

export default class PostsTable extends Component {
  constructor() {
    super();

    this.state = {
      pages: []
    };
  }

  componentDidMount() {
    getPages().then(pages => this.setState({ pages }));
  }

  render({ }, { pages }) {
    return (
      <div>
        <TableHead>Oldalak <a href="/admin/pages/new">Új oldal</a></TableHead>
        <StyledTable>
          <thead>
            <tr><td>ID</td><td>Cím</td><td>Opciók</td></tr>
          </thead>
          <tbody>
            {pages.map(page =>
              <tr>
                <td>{page.id}</td>
                <td style={{ minWidth: '300px' }}>{page.attributes.short_name}</td>
                <td>
                  <a href={`/admin/pages/${page.id}/edit`}>Szerkeszt</a>
                  <a href="">Töröl</a>
                </td>
              </tr>
            )}
          </tbody>
        </StyledTable>
      </div>
    );
  }
};
