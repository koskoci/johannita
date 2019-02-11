<template>
  <v-container id="header">
    <v-layout row justify-end>
    </v-layout>
    <v-layout row justify-end>
      <template v-if=!isAdminRoute>
        <MenuItem class="secondary-menu"
                  :secondary="true"
                  v-for="item in secondaryMenu"
                  :key="item.to"
                  :title="item.title"
                  :to="item.to"
                  :items="item.items"/>
      </template>
      <MenuItem v-if="getToken()" class="secondary-menu"
                :secondary="true"
                v-bind:title="getEmail()"
                to="/bejelentkezes"
                :items="[
                { title: 'Admin', to: '/admin' },
                { title: 'Profil', to: '#' },
                { title: 'Kilepes', click: this.onLogout }
                ]"
      />
      <MenuItem v-else class="secondary-menu"
                :secondary="true"
                title="Bejelentkezes"
                to="/bejelentkezes"
      />
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
            <!--<v-btn to="/admin/dashboard" flat>Dashboard</v-btn>-->
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
            <MenuItem
              v-for="item in primaryMenu"
              :key="item.to"
              :title="item.title"
              :to="item.to"
              :items="item.items"/>
          </v-toolbar-items>
        </v-toolbar>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
import Logo from './Logo.vue';
import MenuItem from './MenuItem.vue';
import primaryMenu from '../config/primary_menu';
import secondaryMenu from '../config/secondary_menu';

export default {
  name: 'Navigation',
  components: {
    Logo,
    MenuItem,
  },
  data() {
    return {
      primaryMenu,
      secondaryMenu,
    };
  },
  methods: {
    getToken() {
      return window.localStorage.getItem('user_token');
    },
    getEmail() {
      return window.localStorage.getItem('user_email');
    },
    onLogout() {
      window.localStorage.removeItem('user_token');
      window.localStorage.removeItem('user_email');
      window.location.href = '/';
    },
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
</style>
