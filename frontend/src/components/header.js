import { h } from 'preact';
import { HeaderContainer, LogoContainer, Logo, LogoText, Menu } from '../styles/base';

const Header = ({ }) => (
  <HeaderContainer>
    <LogoContainer>
      <Logo src="/assets/logo-2.png" />
      <LogoText>Johannita<br/>Segítő<br/>Szolgálat</LogoText>
    </LogoContainer>
    <Menu>
      <li><a href="">A segítő szolgálat</a></li>
      <li><a href="">Hírlevél</a></li>
      <li><a href="">Kiemelt tevékenységeink</a></li>
      <li><a href="">Adománygyűjtés</a></li>
      <li><a href="">Johannita tábor</a></li>
      <li><a href="">Aktuális projektek</a></li>
      <li><a href="">Kapcsolat</a></li>
    </Menu>
  </HeaderContainer>
);

export default Header;
