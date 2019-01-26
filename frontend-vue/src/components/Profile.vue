<template>
  <div id="profile">
    <router-link to="/bejelentkezes">Bejelentkezés</router-link>
    /
    <router-link to="/regisztracio">Regisztráció</router-link>
  </div>
</template>

<script>
export default {
  name: 'Profile',
};
</script>

<style scoped>
  #profile {
    margin-right: 16px;
  }
  #profile a {
    text-decoration: none;
    color: black;
    padding: 0;
  }
  #profile a:hover {
    color: red;
  }
</style>
