import styled from 'styled-components';

export const StyledTable = styled.table`
  width: 100%;
  padding: 20px;
  border-collapse: collapse;
  margin-bottom: 30px;
  border: 1px solid #F5F5F5;

  thead tr {
    background-color: #F5F5F5;
  }

  tr {
    border-bottom: 1px solid #F5F5F5;
  }

  td {
    padding: 8px 16px;
  }

  a {
    margin-right: 10px;
  }
`;

export const TableHead = styled.h3`
  padding: 0 15px;
  a {
    font-weight: normal;
    float: right;
    color: white;
    background-color: #1ce5b1;
    padding: 5px 20px;
    border-radius: 3px;
    font-weight: bold;
    font-size: 14px;

    &:hover {
      color: white;
    }
  }
`;
