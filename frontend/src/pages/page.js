import { h, Component } from 'preact';
import { getPage } from '../helpers/api';
import { ContentContainer }  from '../styles/base';

export default class Page extends Component {
  constructor() {
    super();

    this.state = {
      page: null
    };
  }

  componentDidMount() {
    if (this.props.id) {
      getPage(this.props.id).then((page) => {
        this.setState({ page });
      });
    }
  }

  componentWillReceiveProps(newProps) {
    if (newProps.id && newProps.id !== this.props.id) {
      getPage(newProps.id).then((page) => {
        this.setState({ page });
      });
    }
  }

  render({ }, { page }) {
    return (
      <ContentContainer centered>
        {page ? <div>{page.content}</div> : null}
      </ContentContainer>
    );
  }
};
