import { h } from 'preact';
import { MenuList } from '../../styles/header';

const Menu = ({ }) => (
  <MenuList>
    <li><a href="">A segítő szolgálat</a></li>
    <li><a href="">Hírlevél</a></li>
    <li><a href="">Kiemelt tevékenységeink</a></li>
    <li><a href="">Adománygyűjtés</a></li>
    <li><a href="">Johannita tábor</a></li>
    <li><a href="">Aktuális projektek</a></li>
    <li><a href="">Kapcsolat</a></li>
  </MenuList>
);

export default Menu;
