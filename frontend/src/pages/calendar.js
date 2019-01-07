import { h, Component } from 'preact';
import { ContentContainer }  from '../styles/base';
import { CalendarContainer, CalendarDay, CalendarHeader, DayNames }  from '../styles/calendar';

const monthNames = [
  'Január', 'Február', 'Március', 'Április', 'Május', 'Június', 'Július', 'Augusztus', 'Szeptember', 'Október', 'November', 'December'
];

const getDaysCount = (d) => new Date(d.getFullYear(), d.getMonth() + 1, 0).getDate();

export default class Calendar extends Component {
  constructor() {
    super();

    this.state = {
      d: new Date()
    };
  }

  componentDidMount() {}

  generateDays(firstDay, count, currentDay) {
    const days = [];
    let i = 0;
    let iDay = firstDay;

    for (i; i < count; i += 1) {
      days.push(<CalendarDay offMonth={currentDay.getMonth() !== firstDay.getMonth()}>{iDay.getDate()}</CalendarDay>);
      iDay.setDate(iDay.getDate() + 1);
    }

    return days;
  }

  changeMonth(direction) {
    const { d } = this.state;

    if (direction === 'prev') {
      this.setState({ d: new Date(d.getFullYear(), d.getMonth() - 1, 1) });
    }

    if (direction === 'next') {
      this.setState({ d: new Date(d.getFullYear(), d.getMonth() + 1, 1) });
    }
  }

  render({ }, { d }) {
    let count = getDaysCount(d);
    let firstDay = new Date(d.getFullYear(), d.getMonth(), 1);
    let lastDay = new Date(d.getFullYear(), d.getMonth(), count);

    if (firstDay.getDay() !== 0) {
      count += firstDay.getDay() - 1;
      firstDay.setDate(firstDay.getDate() - firstDay.getDay() + 1);
    }

    if (lastDay.getDay() !== 6) {
      count += (7 - lastDay.getDay());
    }

    return (
      <ContentContainer centered>
        <CalendarContainer>
          <CalendarHeader>
            <span className="prev" onClick={() => { this.changeMonth('prev'); }}>&lsaquo;</span>
            {monthNames[d.getMonth()]}
            <span className="next" onClick={() => { this.changeMonth('next'); }}>&rsaquo;</span>
          </CalendarHeader>
          <DayNames>
            <span>HÉTFŐ</span>
            <span>KEDD</span>
            <span>SZERDA</span>
            <span>CSÜTÖRTÖK</span>
            <span>PÉNTEK</span>
            <span>SZOMBAT</span>
            <span>VASÁRNAP</span>
          </DayNames>
          {this.generateDays(firstDay, count, d)}
        </CalendarContainer>
      </ContentContainer>
    );
  }
};
