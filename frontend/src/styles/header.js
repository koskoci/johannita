import styled from 'styled-components';

export const HeaderContainer = styled.div`
  width: 100%;
  text-align: center;
  padding: 10px 0;
  position: relative;
  height: 150px;
`;

export const LogoContainer = styled.div`
  height: 80px;
  width: 180px;
  margin: 20px 0 20px 40px;
  float: left;
`;

export const Logo = styled.img`
  float: left;
  height: 80px;
`;

export const LogoText = styled.p`
  display: inline-block;
  margin: 0;
  padding: 5px;
  font-size: 20px;
`;

export const UserContainer = styled.div`
  float: right;
  text-align: right;
  font-size: 16px;
  width: 800px;
  height: 30px;
  margin: 20px 0;
`;

export const ProfilBlock = styled.div`
  cursor: pointer;
  float: right;

  ul {
    width: 150px;
    display: none;
    list-style: none;
    padding: 12px;
    text-align: center;
    margin: 10px 0 0 0;
    background-color: white;
    box-shadow: 0px 1px 4px 0px rgba(0,0,0,0.25);
    z-index: 100;
    position: relative;

    li {
      font-size: 16px;
      text-transform: uppercase;
      padding: 3px 0;
    }
  }

  &:hover ul {
    display: block;
  }
`;

export const MenuList = styled.ul`
  max-width: calc(100% - 250px);
  float: right;
  list-style: none;
  margin: 10px 0 0 0;
  padding: 0;

  li {
    display: inline-block;

    a {
      text-decoration: none;
      color: black;
      font-size: 16px;
      text-transform: uppercase;
      padding: 10px;

      &:hover, &.active {
        color: red;
        font-weight: bold;
      }
    }

    &:hover ul {
      display: block
    }
  }
`;

export const SubMenu = styled.ul`
  display: none;
  list-style: none;
  padding: 10px;
  margin: 5px 0 0 -10px;
  position: absolute;
  background-color: white;
  box-shadow: 0px 1px 4px 0px rgba(0,0,0,0.25);

  li {
    font-size: 14px;
    text-transform: uppercase;
    display: block;
    padding: 0 10px;
    text-align: left;
    padding: 6px 10px;

    a {
      display: block;
      padding: 0;
    }
  }
`;
