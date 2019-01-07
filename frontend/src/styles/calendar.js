import styled from 'styled-components';

export const CalendarContainer = styled.div`
  border: 1px solid #EEEEEE;
`;

export const CalendarHeader = styled.p`
  text-align: center;
  margin: 10px;

  span {
    font-size: 20px;
    line-height: 14px;
    font-weight: bold;
    padding: 0 10px;
    cursor: pointer;
  }

  span.prev { float: left; }
  span.next { float: right; }
`;

export const DayNames = styled.p`
  background-color: #EEEEEE;
  padding: 10px 0;
  margin-bottom: 0;

  span {
    font-size: 11px;
    display: inline-block;
    width: 14%;
    text-align: center;
  }
`;

export const CalendarDay = styled.span`
  display: inline-block;
  width: 14%;
  padding: 10px;
  text-align: center;

  opacity: ${props => props.offMonth ? '0.35' : '1'};
`;
