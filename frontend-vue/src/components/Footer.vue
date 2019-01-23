<template>
  <v-footer height="auto" dark>
    <ul>
      <li>Cím: H-1056 Budapest Váci utca 62-64</li>
      <li>Telefon: +36-1-266-91-30</li>
      <li>E-mail: info@johannitak.hu</li>
      <li>Facebook: https://www.facebook.com/johannitak.hu/</li>
      <li>&nbsp;</li>
      <li>Adószám: 19650768-1-41</li>
      <li>Főszámlaszáma: OTP BANK Nyrt, 11705008-20410322</li>
      <li>&nbsp;</li>
      <li>© 2018 - Minden jog fenntartva!</li>
    </ul>
  </v-footer>
</template>

<script>
export default {
  name: 'Footer',
};
</script>

<style lang="scss" scoped>
  .theme--dark.v-footer {
    background-color: black;
    color: white;
    width: 100%;
    padding: 20px;

    ul {
      display: block;
      width: 100%;

      li {
        line-height: 1.3;
        font-family: Verdana, Arial, Helvetica, sans-serif;
        width: 100%;
        display: block;
        text-align: center;
        font-size: 13px;
        margin: 2px 0;
      }
    }
  }
</style>
