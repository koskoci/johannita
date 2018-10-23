import { h } from 'preact';
import { MenuList, SubMenu } from '../../styles/header';

const Menu = ({ }) => (
  <MenuList>
    <li>
      <a href="">A segítő szolgálat</a>
      <SubMenu>
        <li><a href="">Elnöki köszöntő</a></li>
        <li><a href="">Rólunk</a></li>
        <li><a href="">Helyi szervezetek</a></li>
        <li><a href="">Közhasznúságú jelentések</a></li>
        <li><a href="">Johanniter international</a></li>
      </SubMenu>
    </li>
    <li>
      <a href="">Hírlevél</a>
    </li>
    <li>
      <a href="">Kiemelt tevékenységeink</a>
      <SubMenu>
        <li><a href="">Elsősegélynyújtás</a></li>
        <li><a href="">Eszközkölcsönzés</a></li>
        <li><a href="">Hedrehelyi idősek klubja</a></li>
        <li><a href="">Humanitárius segélyezés</a></li>
        <li><a href="">Ifjúsági munka</a></li>
        <li><a href="">Katasztrófavédelem</a></li>
        <li><a href="">Mentőszolgálat</a></li>
      </SubMenu>
    </li>
    <li>
      <a href="">Adománygyűjtés</a>
      <SubMenu>
        <li><a href="">Baróti háztűz</a></li>
        <li><a href="">Elsősegély program</a></li>
        <li><a href="">Guti óvoda</a></li>
        <li><a href="">Háromkút iskolatűz</a></li>
        <li><a href="">Kárpátalja</a></li>
        <li><a href="">Táti gázrobbanás</a></li>
        <li><a href="">Teréyni tűz</a></li>
        <li><a href="">Zólyomi család</a></li>
      </SubMenu>
    </li>
    <li>
      <a href="">Johannita tábor</a>
      <SubMenu>
        <li><a href="">Tábor információk</a></li>
        <li><a href="">Jelentkezés a táborba</a></li>
        <li><a href="">A tábor története</a></li>
      </SubMenu>
    </li>
    <li>
      <a href="">Aktuális projektek</a>
    </li>
    <li>
      <a href="">Kapcsolat</a>
    </li>
  </MenuList>
);

export default Menu;
