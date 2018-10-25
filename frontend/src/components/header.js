import { h } from 'preact';
import Menu from './menu';
import AdminMenu from './adminMenu';
import UserDetails from './userDetails';
import { HeaderContainer, LogoContainer, Logo, LogoText } from '../styles/header';

const Header = ({ isAdmin }) => (
  <HeaderContainer>
    <LogoContainer>
      <a href="/">
        <Logo src="/assets/logo.png" />
        <LogoText>Johannita<br/>Segítő<br/>Szolgálat</LogoText>
      </a>
    </LogoContainer>
    <UserDetails />
    {isAdmin ? <AdminMenu /> : <Menu />}
  </HeaderContainer>
);

export default Header;
