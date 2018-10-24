import styled from 'styled-components';

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
  max-width: 300px;
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
