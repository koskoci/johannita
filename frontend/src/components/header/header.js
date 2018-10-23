import { h } from 'preact';
import Menu from './menu';
import UserDetails from './userDetails';
import { HeaderContainer, LogoContainer, Logo, LogoText } from '../../styles/header';

const Header = ({ }) => (
  <HeaderContainer>
    <LogoContainer>
      <a href="/">
        <Logo src="/assets/logo-2.png" />
        <LogoText>Johannita<br/>Segítő<br/>Szolgálat</LogoText>
      </a>
    </LogoContainer>
    <UserDetails />
    <Menu />
  </HeaderContainer>
);

export default Header;
