<template>
    <v-layout align-center>
      <v-flex>
          <img src="../assets/logo.png" alt="johannita logo">
      </v-flex>
      <v-flex>
        <div class="logo-text">
          <div>Johannita</div>
          <div>Segítő</div>
          <div>Szolgálat</div>
        </div>
      </v-flex>
    </v-layout>
</template>

<script>
export default {
  name: 'Logo',
};
</script>

<style scoped>
  div.logo-text {
    text-decoration: none;
    color: black;
    text-align: center;
  }
  img {
    display: block;
  }
</style>
