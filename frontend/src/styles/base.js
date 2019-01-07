import styled, { css } from 'styled-components';

export const AppContainer = styled.div`
  max-width: 1320px;
  padding: 0 20px;
  margin: 0 auto;
  font-size: 14px;

  a {
    color: black;
    text-decoration: none;

    &:hover {
      color: red;
    }
  }
`;

export const ContentContainer = styled.div`
  margin: 60px 0;
  min-height: calc(100vh - 195px - 150px - 120px);

  ${props => props.centered && css`
    width: 400px;
    margin: 60px auto;
  `}
`;

export const FooterContainer = styled.div`
  width: 100%;
  text-align: center;
  font-size: 13px;
  color: white;
  background-color: black;
  padding: 20px;

  p {
    margin: 2px 0;
  }
`;

export const StyledInput = styled.input`
  color: #212121;
  background-color: #fff;
  border-radius: 3px;
  border: 1px solid transparent;
  box-shadow: 0px 1px 4px 0px rgba(0,0,0,0.2);
  margin-bottom: 10px;
  display: block;
  text-align: center;
  padding: 8px 12px;
  margin: 5px auto 20px;
  min-width: 220px;

  ${props => props.simple && css`
    margin: 0;
    display: inline-block;
    text-align: left;
  `}

  ${props => props.block && css`
    display: block;
  `}
`;

export const StyledTextArea = styled.textarea`
  color: #212121;
  background-color: #fff;
  border-radius: 3px;
  border: 1px solid transparent;
  box-shadow: 0px 1px 4px 0px rgba(0,0,0,0.2);
  margin-bottom: 10px;
  display: block;
  text-align: left;
  padding: 8px 12px;
  margin: 5px 0 20px;
  min-width: 400px;
  min-height: 250px;
`;

export const StyledButton = styled.button`
  background-color: #1ce5b1;
  border: 0;
  border-radius: 3px;
  font-weight: bold;
  color: #FAFAFA;
  padding: 10px 20px;
  cursor: pointer;
`;
