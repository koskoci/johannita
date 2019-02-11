<template>
    <v-layout align-center>
      <v-flex>
          <img src="../assets/logo2.png" alt="johannita logo" height="100">
      </v-flex>
      <v-flex>
        <div class="logo-text">
          <div>A hit védelme és a rászorulók támogatása</div>
          <div>Defensio Fidei et Obsequium Pauperum</div>
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
    margin-left: 10px;
  }
  img {
    display: block;
  }
</style>
