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
`

export const HeaderContainer = styled.div`
  width: 100%;
  text-align: center;
  padding: 10px 0;
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

export const Menu = styled.ul`
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

export const PostContainer = styled.div`
  margin: 20px 0;
  padding: 0;

  &::after {
    content: '';
    display: block;
    clear: both;
  }
`;

export const PostThumb = styled.img`
  float: left;
  margin-right: 20px;
`;

export const PostData = styled.div`
  float: left;
`;

export const PostTitle = styled.a`
  margin: 0;
  color: red;
  text-decoration: none;
  font-weight: bold;
`

export const PostDate = styled.p`
  margin: 2px 0;
  font-size: 13px;
`

export const PostContent = styled.div`
  margin-top: 15px;
`;
