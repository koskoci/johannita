import { h } from 'preact';
import { MenuList } from '../styles/header';

const AdminMenu = ({ }) => (
  <MenuList>
    <li>
      <a href="/admin">Dashboard</a>
    </li>
    <li>
      <a href="/admin/pages">Oldalak</a>
    </li>
    <li>
      <a href="/admin/posts">Hírek</a>
    </li>
    <li>
      <a href="/admin/users">Felhasználók</a>
    </li>
    <li>
      <a href="/admin/course_categories">Esemény kategóriák</a>
    </li>
    <li>
      <a href="/admin/course_events">Tanfolyam események</a>
    </li>
    <li>
      <a href="/admin/courses">Tanfolyamok</a>
    </li>
  </MenuList>
);

export default AdminMenu;
