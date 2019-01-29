<template>
  <v-app>
    <v-content class="wrapper">
      <Navigation/>
      <router-view/>
    </v-content>
    <Footer/>
  </v-app>
</template>

<script>
import Footer from './components/Footer.vue';
import Navigation from './components/Navigation.vue';

export default {
  name: 'App',
  components: {
    Footer,
    Navigation,
  },
  data() {
    return {
      //
    };
  },
};
</script>

<style lang="scss">
  body, html {
    background-color: white;
  }

  .theme--light.application {
    background-color: white;
  }

  .wrapper {
    width: 1200px;
    align-self: center;
  }
  .active-item {
    color: red;
  }
  .content-image-right {
    float: right;
    margin: 0 20px 10px 10px;
  }
  .content-image-left {
    float: left;
    margin: 10px 20px 10px 0;
  }
  .content-image-center {
    display: block;
    margin: 10px auto;
  }
  #my-editor:after {
    content: "";
    display: table;
    clear: both;
  }

  .v-toolbar__content {
    padding-right: 0;
  }
  .v-timeline-item__opposite {
    margin-left: -200px;
    display: block !important;
  }

  #my-editor {
    background-color: #f5f5f5;
    // min-height: 200px;
    /*img:after {*/
      /*content: '';*/
      /*display: block;*/
      /*clear: both;*/
    /*}*/
  }
</style>
