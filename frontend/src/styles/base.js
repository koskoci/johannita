import styled from 'styled-components';

export const AppContainer = styled.div`
  width: 960px;
  padding: 0 20px;
  margin: 0 auto;
`;

export const ContentContainer = styled.div`
  margin: 60px 0;
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

export const Overlay = styled.div`
  position: fixed;
  width: 100vw;
  height: 100vh;
  background-color: rgba(0,0,0, 0.4);
  left: 0;
  top: 0;


  display: flex;
  justify-content: center;
  align-items: center;
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

export const OverlayContent = styled.div`
  width: 320px;
  background-color: white;
  text-align: center;
  padding: 40px 25px;
  box-shadow: 0px 1px 4px 0px rgba(0,0,0,0.1);

  label {
    font-size: 14px;
    text-align: center;
    display: block;
    margin: 0 auto;
  }

  h3 {
    margin-top: 0;
  }
`;
