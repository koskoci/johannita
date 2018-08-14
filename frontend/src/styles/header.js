import styled from 'styled-components';

export const HeaderContainer = styled.div`
  width: 100%;
  text-align: center;
  padding: 10px 0;
  position: relative;
`;

export const LogoContainer = styled.div`
  height: 50px;
  width: 120px;
  margin: 20px auto 0;
`;

export const Logo = styled.img`
  float: left;
  height: 50px;
`;

export const LogoText = styled.p`
  display: inline-block;
  margin: 0;
  padding: 0;
  font-size: 14px;
`;

export const UserContainer = styled.div`
  position: absolute;
  right: 0;
  top: 10px;
  width: 100px;
  height: 50px;
  margin: 20px 0;
`;

export const MenuList = styled.ul`
  list-style: none;
  margin: 40px 0 0 0;
  padding: 0;

  li {
    display: inline-block;

    a {
      text-decoration: none;
      color: black;
      font-size: 14px;
      text-transform: uppercase;
      padding: 10px;

      &:hover, &.active {
        color: red;
        font-weight: bold;
      }
    }
  }
`;
