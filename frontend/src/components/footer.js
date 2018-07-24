import { h } from 'preact';
import { FooterContainer }from '../styles/base';

const Header = ({ }) => (
  <FooterContainer>
    <p>Cím: H-1056 Budapest Váci utca 62-64</p>
    <p>Telefon: +36-1-266-91-30</p>
    <p>E-mail: info@johannitak.hu</p>
    <p>Facebook: https://www.facebook.com/johannitak.hu/</p>
    <br/>
    <p>Adószám: 19650768-1-41</p>
    <p>Főszámlaszáma: OTP BANK Nyrt, 11705008-20410322</p>
    <br/>
    <p>© 2018 - Minden jog fenntartva!</p>
  </FooterContainer>
);

export default Header;
