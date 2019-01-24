<template>
  <v-app>
    <div class="nav" v-if=isAdminRoute>
      <AdminNavigation />
    </div>
    <v-content>
      <router-view/>
    </v-content>
    <Footer/>
  </v-app>
</template>

<script>
import Footer from './components/Footer.vue';
import AdminNavigation from './components/admin/Navigation.vue';

export default {
  name: 'App',
  components: {
    Footer,
    AdminNavigation,
  },
  data() {
    return {
      //
    };
  },
  computed: {
    isAdminRoute() {
      return this.$route.path.startsWith('/admin');
    },
  },
};
</script>
