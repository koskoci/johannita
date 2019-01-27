<template>
  <v-container id="header">
    <v-layout row justify-end>
      <Profile />
    </v-layout>
    <v-layout row align-center>
      <v-flex shrink>
        <router-link to="/">
          <Logo/>
        </router-link>
      </v-flex>
      <v-flex grow class="menu">
        <v-toolbar flat color="white" v-if=isAdminRoute>
          <v-spacer></v-spacer>
          <v-toolbar-items>
            <v-btn to="/admin/dashboard" flat>Dashboard</v-btn>
            <v-btn to="/admin/pages" flat>Oldalak</v-btn>
            <v-btn to="/admin/posts" flat>Hirek</v-btn>
            <v-btn to="/admin/users" flat>Felhasznalok</v-btn>
            <v-btn to="/admin/course_categories" flat>Esemény kategóriák</v-btn>
            <v-btn to="/admin/course_events" flat>Tanfolyam események</v-btn>
            <v-btn to="/admin/courses" flat>Tanfolyamok</v-btn>
          </v-toolbar-items>
        </v-toolbar>
        <v-toolbar id="public-menu" flat color="white" v-else>
          <v-spacer></v-spacer>
          <v-toolbar-items>
            <v-menu open-on-hover offset-y>
              <v-btn flat slot="activator">A segítő szolgálat</v-btn>
              <SubMenu v-bind:items="menu.rolunk"/>
            </v-menu>
            <v-menu open-on-hover offset-y>
              <v-btn flat slot="activator">Tevékenységeink</v-btn>
              <SubMenu v-bind:items="menu.tevekenyseg"/>
            </v-menu>
            <v-menu open-on-hover offset-y>
              <v-btn flat slot="activator">Számítunk rád!</v-btn>
              <SubMenu v-bind:items="menu.jelentkezes"/>
            </v-menu>
            <v-menu open-on-hover offset-y>
              <v-btn flat slot="activator">Támogatás</v-btn>
              <SubMenu v-bind:items="menu.tamogatas"/>
            </v-menu>
            <v-menu open-on-hover offset-y>
              <v-btn flat slot="activator">Johannita Tábor</v-btn>
              <SubMenu v-bind:items="menu.tabor"/>
            </v-menu>
            <v-menu open-on-hover offset-y>
              <v-btn flat slot="activator">Kapcsolat</v-btn>
              <SubMenu v-bind:items="menu.kapcsolat"/>
            </v-menu>
          </v-toolbar-items>
        </v-toolbar>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
import Logo from './Logo.vue';
import SubMenu from './SubMenu.vue';
import Profile from './Profile.vue';

export default {
  name: 'Navigation',
  components: {
    Logo,
    SubMenu,
    Profile,
  },
  data() {
    return {
      menu: {
        rolunk: [
          { title: 'Elnöki köszöntő', to: '/oldal/elnoki_koszonto' },
          { title: 'Rólunk', to: '/oldal/rolunk' },
          { title: 'Helyi szervezetek', to: '/oldal/helyi_szervezetek' },
          { title: 'Közhasznúságú jelentések', to: '/oldal/kozhasznu_jelentesek' },
          { title: 'Aktuális projektek', to: '/oldal/projektek' },
          { title: 'Johanniter International', to: '/oldal/johanniter' },
        ],
        tevekenyseg: [
          { title: 'Elsősegélynújtás', to: '/oldal/elnoki_koszonto' },
          { title: 'Eszközkölcsönzés', to: '/oldal/eszkozkolcsonzes' },
          { title: 'Hedrehelyi idősek klubja', to: '/oldal/hedrelyi_idosek_kluja' },
          { title: 'Humanitárius segélyezés', to: '/oldal/humanitarius_segelyezes' },
          { title: 'Ifjúsági munka', to: '/oldal/ifjusagi_munka' },
          { title: 'Katasztrófavédelem', to: '/oldal/katasztrofavedelem' },
          { title: 'Mentőszolgálat', to: '/oldal/mentoszolgalat' },
        ],
        jelentkezes: [
          { title: 'Jelentkezés Képzésre', to: '/oldal/jelentkezes_kepzes' },
          { title: 'Jelentkezes Onkentes Lehetosegekre', to: '/oldal/jelentkezes_onkentes' },
        ],
        tamogatas: [
          { title: 'Báróti háztűz', to: '/oldal/elnoki_koszonto' },
          { title: 'Elsősegély program', to: '/oldal/rolunk1' },
          { title: 'Guti Óvoda', to: '/oldal/helyi_szervezetek' },
          { title: 'Háromkút Iskolatűz', to: '/oldal/kozhasznu_jelentesek' },
          { title: 'Kárpátalja', to: '/oldal/karpatalja' },
          { title: 'Táti gázrobbanás', to: '/oldal/gazrobbanas_tat' },
          { title: 'Terényi tűz', to: '/oldal/terenyi_tuz' },
          { title: 'Zólyomi család', to: '/oldal/zolyomi_csalad' },
        ],
        tabor: [
          { title: 'Tábor információk', to: '/oldal/tabor_informaciok' },
          { title: 'Jelentkezés a táborba', to: '/oldal/tabor_jelentkezes' },
          { title: 'A tábor története', to: '/oldal/tabor_tortenet' },
        ],
        kapcsolat: [
          { title: 'Hírlevel', to: '/oldal/foo_bar' },
        ],
      },
    };
  },
  computed: {
    isAdminRoute() {
      return this.$route.path.startsWith('/admin');
    },
  },
};
</script>

<style scoped>
  a {
    text-decoration: none;
  }
  button:hover {
    color: red;
    background-color: transparent;
  }

  #header {
    margin: 0;
    padding: 10px;
  }

  /*menu {*/
    /*padding-right: 0;*/
  /*}*/

</style>
