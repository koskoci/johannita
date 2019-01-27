<template>
  <div class="user-profile-logged-in" v-if="getToken()">
    <v-menu open-on-hover offset-y>
      <v-btn
        flat
        slot="activator"
      >
        {{getEmail()}}
      </v-btn>
      <v-list>
        <v-list-tile
          v-for="(item, index) in items"
          :key="index"
          v-bind:to="item.to"
        >
          <v-list-tile-title>{{ item.title }}</v-list-tile-title>
        </v-list-tile>
        <v-divider></v-divider>
        <v-list-tile @click="logout">
          <v-list-tile-title>Logout</v-list-tile-title>
        </v-list-tile>
      </v-list>
    </v-menu>
  </div>
  <div class="user-profile" v-else>
    <router-link to="/bejelentkezes">Bejelentkezés</router-link>
    /
    <router-link to="/regisztracio">Regisztráció</router-link>
  </div>
</template>

<script>
export default {
  name: 'Profile',
  data: () => ({
    items: [
      { title: 'Profil', to: '#' },
      { title: 'Admin', to: '/admin' },
    ],
  }),
  methods: {
    getToken() {
      return window.localStorage.getItem('user_token');
    },
    getEmail() {
      return window.localStorage.getItem('user_email');
    },
    logout() {
      window.localStorage.removeItem('user_token');
      window.localStorage.removeItem('user_email');
      window.location.href = '/';
      console.log('logout');
    },
  },
};
</script>

<style lang="scss" scoped>
  .user-profile {
    margin-right: 16px;
    a {
      text-decoration: none;
      color: black;
      padding: 0;
    }
    a:hover {
      color: red;
    }
  }
  .user-profile-logged-in {
    .v-menu__activator button {
      margin: 0;
    }
  }
</style>
